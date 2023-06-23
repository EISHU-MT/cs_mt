-- Storage
local storage = minetest.get_mod_storage()
-- Global tables
do
	wand = {}
	wand_nodes = {}
	area_status = {}
	uncompress = core.deserialize
	compress = core.serialize
end
--Locak table
local new = {
	mapname = "name_this_new_map",
	mapauthor = nil,
	maptitle = "name this map",
	barrier_r = 110,
	barrier_rot = 0,
	center = { x = 0, y = 0, z = 0, r = 115, h = 140 },
	teams = {},
	bomb_areas = {},
	areas = {},
	physics = {jump = 1, speed = 1, gravity = 1},
}

local c_ind_stone = minetest.get_content_id("mcore:stone")
local c_ind_glass = minetest.get_content_id("mcore:ind_glass")
local c_ignore = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")

local context = {
	mapname = storage:get_string("mapname"),
	maptitle = storage:get_string("maptitle"),
	mapauthor = storage:get_string("mapauthor"),
	mapinitial = storage:get_string("mapinitial"),
	center = storage:get_string("center"),
	bomb_areas = storage:get_string("bomb_areas"),
	teams = storage:get_string("teams"),
	areas = storage:get_string("areas"),
	barrier_r = storage:get_int("barrier_r"),
	barrier_rot = storage:get_string("barrier_rot"),
	barriers_placed = storage:get_int("barriers_placed") == 1,
	physics = storage:get_string("physics")
}

function return_context()
	return context
end

function mod_contextSTATUS(name, contents)
	context.areas[name] = contents
	storage:get_string("areas", core.serialize(context.areas))
end

-- Wand for areas!
local wand_def = {
	description = "Wand of Areas\nSets positions for non-radius areas\nRight-click an node to set 1. or 2. position.",
	short_description = "Wand of Areas",
	inventory_image = "cs_files_area_tool.png",
	range = 15,
	liquids_pointable = true,
	on_place = function(itemstack, placer, pointed_thing)
		local name = Name(placer)
		local player = Player(placer)
		if not wand[name] then
			wand[name] = {}
		end
		if wand[name].pos1 == nil or not wand[name].pos1 then
			if pointed_thing.type == "node" then
				local pos = pointed_thing.under
				local dist = vector.distance(pos, player:get_pos())
				if dist >= 100 then
					function empty() end
					empty()
				else
					wand[name].pos1 = pos
					core.set_node(pointed_thing.above, {name="mcore:display_node"})
					table.insert(wand_nodes, vector.new(pointed_thing.above))
				end
				return
			end
		end
		if wand[name].pos2 == nil or not wand[name].pos2 then
			if pointed_thing.type == "node" then
				local pos = pointed_thing.under
				local dist = vector.distance(pos, player:get_pos())
				if dist >= 100 then
					function empty() end
					empty()
				else
					wand[name].pos2 = pos
					core.set_node(pointed_thing.above, {name="mcore:display_node"})
					table.insert(wand_nodes, vector.new(pointed_thing.above))
				end
				return
			end
		end
		print(dump(wand[name]))
		if type(wand[name].pos1) == "table" and type(wand[name].pos2) == "table" then
			core.chat_send_player(name, "All positions done!")
			core.chat_send_player(name, "Sending a menu to configure the pos.")
			core.show_formspec(name, "mm:wand1", return_formspec("Not available!", "Wand"))
		end
	end,
	on_use = function(itemstack, user, pointed_thing)
		local name = Name(user)
		if not wand[name] then
			wand[name] = {pos1 = nil, pos2 = nil}
		end
		core.show_formspec(Name(user), "mm:wand", wand_formspec(core.pos_to_string(wand[name].pos1 or {x = 0, y = 0, z = 0}) or "<non set>", core.pos_to_string(wand[name].pos2 or {x = 0, y = 0, z = 0}) or "<non set>", ""))
	end,
}

if context.mapname == "" then
	context.mapname = new.mapname
end
if context.mapauthor == "" then
	context.mapauthor = new.mapauthor
end
if context.maptitle == "" then
	context.maptitle = new.maptitle
end
if context.barrier_r == 0 then
	context.barrier_r = new.barrier_r
end
if context.center == "" then
	context.center = new.center
else
	context.center = uncompress(storage:get_string("center")) or { x = 0, y = 0, z = 0, r = 115, h = 140 }
end
if context.teams == "" then
	context.teams = new.teams
else
	context.teams = uncompress(storage:get_string("teams")) or {}
end
if context.bomb_areas == "" then
	context.bomb_areas = new.bomb_areas
else
	context.bomb_areas = uncompress(storage:get_string("bomb_areas")) or {}
end
if context.status == "" then
	context.areas = areas
else
	context.areas = uncompress(storage:get_string("areas")) or {}
end
if context.physics == "" then
	context.physics = new.physics
else
	context.physics = uncompress(storage:get_string("physics")) or {jump = 1, speed = 1, gravity = 1}
end
-- Register things
-- Special pick
minetest.register_tool("mcore:pick", {
	description = "Special Pickage. Can dig indestructible nodes, group: {immortal}",
	inventory_image = "cs_files_spc_pick.png",
	range = 16,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 3,
		groupcaps = {
			immortal = {times = {[1] = 0.5}, uses = 0, maxlevel = 3}
		},
		damage_groups = {fleshy = 20}
	}
})
-- Each node for teams
minetest.register_node("mcore:terrorist", {
	description = "Terrorist block",
	drawtype = "mesh",
	mesh = "character.b3d",
	paramtype = "light",
	walkable = false,
	tiles = {
		"red.1.png",
	},
	groups = {oddly_breakable_by_hand=1,snappy=3},
	after_place_node = function(pos)
		context.teams.terrorist = vector.new(pos)
		storage:set_string("teams", compress(context.teams))
	end,
	on_destruct = function(pos)
		context.teams.terrorist = nil
		storage:set_string("teams", compress(context.teams))
	end,
})
minetest.register_node("mcore:counter", {
	description = "Counters block",
	drawtype = "mesh",
	mesh = "character.b3d",
	paramtype = "light",
	walkable = false,
	tiles = {
		"blue.png",
	},
	groups = {oddly_breakable_by_hand=1,snappy=3},
	after_place_node = function(pos)
		context.teams.counter = vector.new(pos)
		storage:set_string("teams", compress(context.teams))
	end,
	on_destruct = function(pos)
		context.teams.counter = nil
		storage:set_string("teams", compress(context.teams))
	end,
})
-- Register node for non-radius areas
minetest.register_node("mcore:display_node", {
	description = "Sign node that marks the non-radius area",
	drawtype="nodebox",
	paramtype = "light",
	walkable = false,
	tiles = {
		"cs_files_area.png",
	},
	groups = {oddly_breakable_by_hand=1,snappy=3},
})
-- Register object for areas
minetest.register_entity("mcore:display", {
	physical = false,
	collisionbox = {0, 0, 0, 0, 0, 0},
	visual = "cube",
	textures = {"cs_files_show_area.png", "cs_files_show_area.png", "cs_files_show_area.png", "cs_files_show_area.png", "cs_files_show_area.png", "cs_files_show_area.png"},
	timer = 0,
	glow = 10,
	on_step = function(self, dtime)
		self.timer = self.timer + dtime
		if self.timer > 5 then
			self.object:remove()
		end
	end
})
-- Register for areas tool
minetest.register_node("mcore:area", {
	description = "Area node.", 
	drawtype = "nodebox",
	tiles = {"cs_files_area.png", "cs_files_area.png", "cs_files_area.png", "cs_files_area.png", "cs_files_area.png", "cs_files_area.png", "cs_files_area.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable     = true,
	pointable    = false,
	diggable     = true,
	buildable_to = false,
	air_equivalent = true,
	after_place_node = function(pos, placer)
		area_status[Name(placer)] = {position = pos, usrd = placer}
		core.show_formspec(Name(placer), "mm:areas", return_formspec())
	end,
	groups = {immortal = 1},
})
-- Register area tool for non-radius areas
core.register_craftitem("mcore:wand", wand_def)

-- Functions
-- Space replacer
function replace_spaces(strings)
	if not strings then
		return "_"
	end
	local str = strings:gsub(" ", "_")
	return str
end
-- Real pos checker
function is_real_pos(pos)
	return type(pos) == "table" and type(pos.x) == "number" and type(pos.y) == "number" and type(pos.z) == "number"
end

local function get_teams()
	local negative = nil
	local positive = nil
	for name, pos in pairs(context.teams) do
		if name == "counter" then
			positive = pos
		elseif name == "terrorist" then
			negative = pos
		end
	end
	return negative, positive
end

function get_node_status()
	local stat1, stat2 = get_teams()
	local msg
	if stat1 and not stat2 then
		msg = "Place one more team spawn"
	elseif stat2 and not stat1 then
		msg = "Place one more team spawn"
	elseif stat1 and stat2 then
		msg = "Ready!"
	elseif not stat1 and not stat2 then
		msg = "Place each team in different places"
	end
	return msg or "error"
end

local function to_2pos()
	return {
		x = context.center.x - context.center.r,
		y = context.center.y - context.center.h / 2,
		z = context.center.z - context.center.r,
	}, {
		x = context.center.x + context.center.r,
		y = context.center.y + context.center.h / 2,
		z = context.center.z + context.center.r,
	}
end

function put_a_bomb(player)
	nr = player:get_pos()
	nr.x = math.floor(nr.x)
	nr.y = math.floor(nr.y)
	nr.z = math.floor(nr.z)
	context.bomb_areas.a = vector.new(nr)
	storage:set_string("bomb_areas", compress(context.bomb_areas))
end
function put_b_bomb(player)
	nr = player:get_pos()
	nr.x = math.floor(nr.x)
	nr.y = math.floor(nr.y)
	nr.z = math.floor(nr.z)
	context.bomb_areas.b = vector.new(nr)
	storage:set_string("bomb_areas", compress(context.bomb_areas))
end

function set_meta(k, v)
	if v ~= context[k] then
		context[k] = v
		if type(v) == "number" then
			storage:set_int(k, v)
		else
			storage:set_string(k, v)
		end
	end
end

local max = math.max

function emerge(name)
	local pos1, pos2 = to_2pos()
	show_progress_formspec(name, "Emerging area...")
	maps.emerge_with_callbacks(name, pos1, pos2, function()
		show_gui(name)
	end, emerge_progress)
	return true
end

function we_select(name)
	local pos1, pos2 = to_2pos()
	worldedit.pos1[name] = pos1
	worldedit.mark_pos1(name)
	worldedit.player_notify(name, "position 1 set to " .. minetest.pos_to_string(pos1))
	worldedit.pos2[name] = pos2
	worldedit.mark_pos2(name)
	worldedit.player_notify(name, "position 2 set to " .. minetest.pos_to_string(pos2))
end

function we_import(name)
	local pos1 = worldedit.pos1[name]
	local pos2 = worldedit.pos2[name]
	if pos1 and pos2 then
		local size = vector.subtract(pos2, pos1)
		local r = max(size.x, size.z) / 2
		context.center = vector.divide(vector.add(pos1, pos2), 2)
		context.center.r = r
		context.center.h = size.y
		storage:set_string("center", compress(context.center))
	end
end

function set_center(name, center)
	if center then
		for k, v in pairs(center) do
			context.center[k] = v
		end
	else
		local r   = context.center.r
		local h   = context.center.h
		local pos = minetest.get_player_by_name(name):get_pos()
		context.center = vector.floor(pos)
		context.center.r = r
		context.center.h = h
	end
	storage:set_string("center", compress(context.center))
end

local function get_barrier_node(c_id)
	if c_id == c_air or c_id == c_ind_glass or c_id == c_ignore then
		return c_ind_glass
	else
		return c_ind_stone
	end
end

function place_outer_barrier(center, r, h)
	local minp = vector.subtract(center, r)
	local maxp = vector.add(center, r)
	minp.y = center.y - h / 2
	maxp.y = center.y + h / 2
	minetest.log("action", "Map maker: Loading data into LVM")
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local a = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	local data = vm:get_data()
	-- Left
	minetest.log("action", "Map maker: Placing left wall")
	do
		local x = center.x - r
		for z = minp.z, maxp.z do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end
	-- Right
	minetest.log("action", "Map maker: Placing right wall")
	do
		local x = center.x + r
		for z = minp.z, maxp.z do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end
	-- Front
	minetest.log("action", "Map maker: Placing front wall")
	do
		local z = center.z - r
		for x = minp.x, maxp.x do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end
	-- Back
	minetest.log("action", "Map maker: Placing back wall")
	do
		local z = center.z + r
		for x = minp.x, maxp.x do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end
	-- Bedrock
	minetest.log("action", "Map maker: Placing bedrock")
	do
		local y = minp.y
		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				data[a:index(x, y, z)] = c_ind_stone
			end
		end
	end
	-- Ceiling
	minetest.log("action", "Map maker: Placing ceiling")
	do
		local y = maxp.y
		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				data[a:index(x, y, z)] = c_ind_glass
			end
		end
	end
	minetest.log("action", "Map maker: Writing to engine!")
	vm:set_data(data)
	vm:write_to_map(data)
	vm:update_map()
end

function place_barriers(name)
	show_progress_formspec(name, "Emerging area...")
	local pos1, pos2 = to_2pos()
	maps.emerge_with_callbacks(name, pos1, pos2, function()
		show_progress_formspec(name, "Placing center barrier, this may take a while...")
		minetest.after(0.1, function()
			show_progress_formspec(name, "Placing outer barriers, this may take a while...")
			minetest.after(0.1, function()
				place_outer_barrier(context.center, context.barrier_r, context.center.h)
				show_gui(name)
			end)
		end)
	end, emerge_progress)
	return true
end


function export(name)
	local s1, s2 = get_teams()
	if not s1 or not s2 then
		minetest.chat_send_all("You need to place two nodes in each sides!!")
		return
	end
	if not context.bomb_areas.a and not context.bomb_areas.b then
		minetest.chat_send_all("You need to place two areas in each sides for the bomb!!")
		return
	end

	we_select(name)
	show_progress_formspec(name, "Exporting...")

	local path = minetest.get_worldpath() .. "/schems/" .. context.mapname .. "/"
	minetest.mkdir(path)
	local init_file, r = io.open(path.."init.lua", "w")
	local conf, r = io.open(path.."mod.conf", "w")
	if not init_file then
		error("Could not create initial file for map! Reason: "..tostring(r))
	end

	-- Reset mod_storage
	storage:set_string("center", "")
	storage:set_string("maptitle", "")
	storage:set_string("mapauthor", "")
	storage:set_string("mapname", "")
	storage:set_string("mapinitial", "")
	storage:set_string("barrier_rot", "")
	storage:set_string("barrier_r", "")
	
	-- Add initial files
	local function w(str) init_file:write("\n"..str) end
	init_file:write("--[[\n")
	init_file:write("\n	This file (init.lua) was generated by a machine")
	init_file:write("\n--]]")
	w("local modpath = core.get_modpath(core.get_current_modname())")
	w("maps.register_map(\""..context.mapname.."\", {")
	w("	name = \""..context.maptitle.."\",")
	w("	dirname = modpath,")
	w("})")
	w("--- END OF GEN. FILE ---")
	init_file:close()
	
	conf:write("name = "..context.mapname)
	conf:write("\ndepends = mcore")
	conf:close()
	
	local meta = Settings(path .. "map.cfg")
	meta:set("name", context.maptitle)
	meta:set("author", context.mapauthor)
	if context.mapinitial ~= "" then
		meta:set("initial_stuff", context.mapinitial)
	end
	meta:set("rotation", context.barrier_rot)
	meta:set("r", context.center.r)
	meta:set("h", context.center.h)

	for name, nspos in pairs(context.teams) do
		if name and nspos then
			if type(nspos) == "table" and type(name) == "string" then
				if name == "terrorist" or name == "counter" then
					local pos = vector.subtract(nspos, context.center)
					meta:set("team." .. name, minetest.pos_to_string(pos))
				end
			end
		end
	end
	for state, nrpos in pairs(context.bomb_areas) do
		if type(state) == "string" then
			if state == "a" or state == "b" then
				local pos = vector.subtract(nrpos, context.center)
				meta:set("areas." .. state, minetest.pos_to_string(pos))
			elseif state ~= "a" and state ~= "b" then
				core.log("error", "A name for bombs positons is not correct!:\nName: "..tostring(state).."\nContents: "..tostring(dump(nrpos)))
			end
		end
	end
	local status_table = {}
	for name, tabled in pairs(context.areas) do
		if tabled.nonradius ~= true then
			local pos = vector.subtract(tabled.position, context.center)
			status_table[name] = {
				pos = minetest.pos_to_string(pos),
				str = tabled.name,
				rad = tabled.rad or 10
			}
		elseif tabled.nonradius == true then
			if is_real_position(tabled.positions.pos1) and is_real_position(tabled.positions.pos2) then
				local pos1 = vector.subtract(tabled.position.pos1, context.center)
				local pos2 = vector.subtract(tabled.position.pos2, context.center)
				status_table[name] = {
					pos = {p1 = minetest.pos_to_string(pos1), p2 = minetest.pos_to_string(pos2)},
					str = tabled.name,
				}
			end
		end
	end
	
	meta:set("status", core.serialize(status_table))
	meta:set("physics", storage:get_string("physics"))
	meta:write()

	minetest.after(0.1, function()
		local filepath = path .. "core.mts"
		if minetest.create_schematic(worldedit.pos1[name], worldedit.pos2[name],
				worldedit.prob_list[name], filepath) then
			minetest.chat_send_all("Exported " .. context.mapname .. " to " .. path)
			minetest.close_formspec(name, "")
		else
			minetest.chat_send_all("Failed!")
			show_gui(name)
		end
	end)
	return
end






