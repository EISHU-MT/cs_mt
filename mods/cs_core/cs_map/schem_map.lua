local mapm = minetest.settings:get_bool("cs_map.mapmaking", false)
if not mapm then
assert(minetest.get_mapgen_setting("mg_name") == "singlenode", "singlenode mapgen is required.")
end


function cs_map.log(act, message)
if act and message then

if (act == "warn") then
core.log("warning", message)
end

if (act == "action") then
core.log("action", message)
end

if (act == "error") then
core.log("error", message)
end

if (act == "ferror") then
error(message)
end

end
end



local max_r   = 120
cs_map.map    = nil
cs_map.mapdir = minetest.get_modpath(minetest.get_current_modname()) .. "/cs_maps/"


function cs_map.get_idx_and_map(param)
	param = param:lower():trim()
	for i, map in pairs(cs_map.available_maps) do
		if map.name:lower():find(param, 1, true) or
				map.dirname:lower():find(param, 1, true) then
			return i, map
		end
	end
end

cs_map.next_idx = nil
local function set_next_by_param(name, param)
	local idx, map = cs_map.get_idx_and_map(param)
	if idx then
		cs_map.next_idx = idx
		return true, "Selected " .. map.name
	else
		return false, "Couldn't find any matching map!"
	end
end

core.register_chatcommand("set_next_map", {
	description = "Sets next map",
	params = "<map name>",
	func = set_next_by_param,
	privs = {core=true}
})

local function load_map_meta(idx, dirname, meta)
	cs_map.log("action", "load_map_meta: Loading map meta from '" .. dirname .. "/map.conf'")
	if not meta:get("r") then
		error("Map was not properly configured: " .. dirname .. "/map.conf")
	end

	local offset = vector.new(600 * idx, 0, 0)

	local initial_stuff = meta:get("initial_stuff")
	local treasures = meta:get("treasures")
	local start_time = meta:get("start_time")
	local time_speed = meta:get("time_speed")

	local map = {
		dirname       = dirname,
		name          = meta:get("name"),
		r             = tonumber(meta:get("r")),
		h             = tonumber(meta:get("h")),
		author        = meta:get("author"),
		rotation      = meta:get("rotation"),
		license       = meta:get("license"),
		initial_stuff = initial_stuff and initial_stuff:split(","),
		offset        = offset,
				-- Functions
		functions     = meta:get_bool("enable_functions", false),
		onactivate    = meta:get_bool("on_activate", false),
		onload        = meta:get_bool("on_load", false),
		
		act_dir       = cs_map.mapdir .. dirname .. "/on_activate.lua",
		
		status        = core.deserialize(meta:get("status")),
		area_status   = {},
		
		teams         = {},
		bareas        = {},
	}

	assert(map.r <= max_r)

	map.pos1 = vector.add(offset, { x = -map.r, y = -map.h / 2, z = -map.r })
	map.pos2 = vector.add(offset, { x =  map.r, y =  map.h / 2, z =  map.r })
	
	
	if map.onload then
		dofile(cs_map.mapdir..dirname.."/init.lua")
	end
	
	
	local i = 1
	while meta:get("team." .. i) do
		local tname  = meta:get("team." .. i)
		local tpos   = minetest.string_to_pos(meta:get("team." .. i .. ".pos"))

		map.teams[tname] = {
			color = tcolor,
			pos = vector.add(offset, tpos),
		}
		

		i = i + 1
	end
	local i2 = 1
	while meta:get("areas." .. i2) do
		local area = meta:get("areas." .. i2)
		local areap = minetest.string_to_pos(meta:get("areas." .. i2 .. ".pos"))
		map.bareas[area] = {
			--color = tcolor,
			pos = vector.add(offset, areap),
		}
		i2 = i2 + 1
	end
	if type(map.status) == "table" then
		for name, value in pairs(map.status) do
			if name and type(value) == "table" and value.pos and value.str then
				if minetest.settings:get_bool("cs_core.enable_env_debug", false) then
					core.log("action", "Registering "..name.." for Area status....")
				end
				if type(map.area_status[name]) ~= "table" then
					map.area_status[name] = {}
				end
				map.area_status[name].pos = vector.add(offset, core.string_to_pos(value.pos))
				map.area_status[name].str = value.str
				map.area_status[name].rad = value.rad or 10 -- radius is now available
			end
		end
	end
	local response = meta:get("enable_bomb") or "no"
	if response == "no" then
		map.enable_bomb = false
	elseif response == "yes" then
		map.enable_bomb = true
	end







	return map
end
function cs_map.get_status_of_areas()
	return type(cs_map.map.area_status) == "table"
end
function cs_map.get_name_of_pos(pos)
	if cs_map.get_status_of_areas() then
		for i, val in pairs(cs_map.map.area_status) do
			if vector.distance(val.pos, pos) <= val.rad then
				return val.str or "--"
			end
		end
	else
		return "--"
	end
	return "--"
end

-- List of shuffled map indices, used in conjunction with random map selection
local shuffled_order = {}
local shuffled_idx

math.randomseed(os.time())

local function shuffle_maps(previous_order, map_recurrence_threshold)
	local maps_count = #cs_map.available_maps

	map_recurrence_threshold = math.min(map_recurrence_threshold or 0, maps_count - 1)

	if previous_order == nil then
		map_recurrence_threshold = 0
		previous_order = {}
		for i = 1, maps_count do
			previous_order[i] = i
		end
	end

	-- Reset shuffled_idx
	shuffled_idx = 1

	-- Create table of ordered indices
	shuffled_order = {}

	-- At first select maps that don't intersect with the last maps from previous order
	for i = 1, map_recurrence_threshold do
		local j = math.random(1, maps_count - map_recurrence_threshold)
		local k = maps_count - map_recurrence_threshold + i
		shuffled_order[i] = previous_order[j]
		previous_order[j] = previous_order[k]
	end

	-- Select remaining maps
	for i = map_recurrence_threshold + 1, maps_count do
		local j = math.random(1, maps_count - i + 1)
		local k = maps_count - i + 1
		shuffled_order[i] = previous_order[j]
		previous_order[j] = previous_order[k]
	end
end

local random_selection_mode = false
local function select_map()
	local idx

	-- If next_idx exists, return the same
	if cs_map.next_idx then
		idx = cs_map.next_idx
		cs_map.next_idx = nil
		return idx
	end

	if random_selection_mode then
		-- Get the real idx stored in table shuffled_order at index [shuffled_idx]
		idx = shuffled_order[shuffled_idx]
		shuffled_idx = shuffled_idx + 1

		-- If shuffled_idx overflows, re-shuffle map selection order
		if shuffled_idx > #cs_map.available_maps then
			shuffle_maps(shuffled_order, 3)
		end
	else
		-- Choose next map index, but don't select the same one again
		if cs_map.map and #cs_map.available_maps > 1 then
			idx = math.random(1, #cs_map.available_maps - 1)
			if idx >= cs_map.map.idx then
				idx = idx + 1
			end
		else
			idx = math.random(1, #cs_map.available_maps)
		end
	end
	return idx
end

local function load_maps()
	local idx = 1
	cs_map.available_maps = {}
	for _, dirname in pairs(minetest.get_dir_list(cs_map.mapdir, true)) do
		if dirname ~= ".git" then
			local conf = Settings(cs_map.mapdir .. "/" .. dirname .. "/map.conf")
			--print(conf)
			-- If map isn't disabled, load map meta
			if not conf:get_bool("disabled", false) then
				local map = load_map_meta(idx, dirname, conf)
				cs_map.available_maps[idx] = map
				idx = idx + 1

				minetest.log("info", "Loaded map '" .. map.name .. "'")
			end
		end
	end

	if not next(cs_map.available_maps) then
		error("No maps found in directory " .. cs_map.mapdir)
	end

	-- Determine map selection mode depending on number of available maps
	-- If random, then shuffle the map selection order
	random_selection_mode = #cs_map.available_maps >=
		(10)
	if random_selection_mode then
		shuffle_maps()
	end

	return cs_map.available_maps
end

load_maps()


function place_map(map)
		cs_map.emerge_with_callbacks(nil, map.pos1, map.pos2, function()
		local schempath = cs_map.mapdir .. map.dirname .. "/map.mts"
		local res = minetest.place_schematic(map.pos1, schempath, map.rotation == "z" and "0" or "90")
		
		--print(locals) -- used for debug.

		assert(res, "Unable to place schematic, does the MTS file exist? Path: " .. schempath)




		minetest.after(10, function()
			minetest.fix_light(cs_map.map.pos1, cs_map.map.pos2)
		end)
		end, nil)
		--cs_core.cooldown(1)
end

cs_map.registered_on_map_loaded = {}
function cs_map.register_on_map_loaded(func)
	cs_map.registered_on_map_loaded[#cs_map.registered_on_map_loaded + 1] = func
end

function cs_map.new_match()
	

	-- Select map
	local idx = select_map()
	cs_map.map = cs_map.available_maps[idx]
	cs_map.map.idx = idx

	
	minetest.clear_objects({ mode = "quick" })
	
	if cs_map.map.functions == true and cs_map.map.on_activate then
		cs_map.map.on_activate(cs_map.map)
	end
	
		-- Terrorists spawn
		function terrorists_spawn()
		terroristsspawn = cs_map.map.teams.terrorist.pos
		return terroristsspawn
		end
		-- (A) bomb area
		function a_bomb_area()
		a = cs_map.map.bareas.a.pos or cs_map.map.bareas.b.pos
		return a
		end
		-- (B) bomb area
		function b_bomb_area()
		b = cs_map.map.bareas.b.pos or cs_map.map.bareas.a.pos
		return b
		end
		-- Counters Spawn
		function counters_spawn()
		countersspawn = cs_map.map.teams.counter.pos
		return countersspawn
		end
		-- Spectators spawn
		function spectators_spawn()
		spect = cs_map.map.teams.counter.pos -- XD they will spawn in a wall
		return spect
		end

	--cs_core.log("action", "--")

	-- Place map
	place_map(cs_map.map)

	function ask_for_bomb() return cs_map.map.enable_bomb end

	-- Update per-map env. like time, time speed, skybox, physics, etc.
	cs_map.update_env()
	

	--print(terrorists_spawn() or "no")
	--print(counters_spawn() or "no")
	
	-- Run on_map_loaded callbacks
	for i = 1, #cs_map.registered_on_map_loaded do
		cs_map.registered_on_map_loaded[i](cs_map.map)
	end

end
