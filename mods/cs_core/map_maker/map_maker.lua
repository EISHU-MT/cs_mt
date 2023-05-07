local storage = minetest.get_mod_storage()
local randint = math.random(100)
area_status = {}
local defaults = {
	mapname = "cs_" .. randint,
	mapauthor = nil,
	maptitle = "Untitled Map " .. randint,
	mapinitial = "",
	barrier_r = 110,
	barrier_rot = 0,
	center = { x = 0, y = 0, z = 0, r = 115, h = 140 },
	nodes = {},
	areas = {},
	status = {}
}
function return_formspec()
	local form = {
	"formspec_version[6]" ..
	"size[10.5,5]" ..
	"box[0,0;12.4,0.8;#009200]" ..
	"label[4.9,0.4;Areas.]" ..
	"field[0.2,1.3;10.1,1.7;str;Please set a name to this area.;Eg: Sector A]" ..
	"button_exit[0.1,4;10.3,0.8;decline;Cancel]" ..
	"button_exit[0.1,3.1;10.3,0.8;accept;Accept]"
	}
	return table.concat(form, "")
end

function replace_spaces(strings)
	if not strings then
		return
	end
	local tabled = strings:split(" ")
	return table.concat(tabled, "_")
end
-- Reload mapmaker context from mod_storage if it exists
local context = {
	mapname = storage:get_string("mapname"),
	maptitle = storage:get_string("maptitle"),
	mapauthor = storage:get_string("mapauthor"),
	mapinitial = storage:get_string("mapinitial"),
	center = storage:get_string("center"),
	areas = storage:get_string("areas"),
	nodes = storage:get_string("nodes"),
	status = core.deserialize(storage:get_string("areas")) or {},
	barrier_r = storage:get_int("barrier_r"),
	barrier_rot = storage:get_string("barrier_rot"),
	barriers_placed = storage:get_int("barriers_placed") == 1
}

if context.mapname == "" then
	context.mapname = defaults.mapname
end
if context.mapauthor == "" then
	context.mapauthor = defaults.mapauthor
end
if context.maptitle == "" then
	context.maptitle = defaults.maptitle
end
if context.barrier_r == 0 then
	context.barrier_r = defaults.barrier_r
end
if context.center == "" then
	context.center = defaults.center
else
	context.center = minetest.parse_json(storage:get_string("center"))
end
if context.nodes == "" then
	context.nodes = defaults.nodes
else
	context.nodes = minetest.parse_json(storage:get_string("nodes"))
end
if context.areas == "" then
	context.areas = defaults.areas
else
	context.areas = minetest.parse_json(storage:get_string("areas"))
end
if context.status == "" then
	context.status = defaults.status
else
	context.status = core.deserialize(storage:get_string("status")) or {}
end
--------------------------------------------------------------------------------


minetest.register_on_joinplayer(function(player)
	
	local inv = player:get_inventory()
	if not inv:contains_item("main", "map_maker:adminpick") then
		inv:add_item("main", "map_maker:adminpick")
	end
end)

minetest.register_on_respawnplayer(function(player)
	local inv = player:get_inventory()
	if not inv:contains_item("main", "map_maker:adminpick") then
		inv:add_item("main", "map_maker:adminpick")
	end
end)

assert(minetest.get_modpath("worldedit") and
		minetest.get_modpath("worldedit_commands"),
		"worldedit and worldedit_commands are required!")

-- Register special pickaxe to break indestructible nodes
minetest.register_tool("map_maker:adminpick", {
	description = "Admin pickaxe used to break indestructible nodes.",
	inventory_image = "map_maker_adminpick.png",
	range = 16,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 3,
		groupcaps = {
			immortal = {times = {[1] = 0.5}, uses = 0, maxlevel = 3}
		},
		damage_groups = {fleshy = 10000}
	}
})

minetest.register_node(":cs_core:terrorists", {
	description = "node\n Used for Terrorists Spawn.",
	drawtype="nodebox",
	paramtype = "light",
	walkable = false,
	tiles = {
		"default_wood.png",
	},
	groups = {oddly_breakable_by_hand=1,snappy=3},
	after_place_node = function(pos)
		table.insert(context.nodes, vector.new(pos))
		storage:set_string("nodes", minetest.write_json(context.nodes))
	end,
	on_destruct = function(pos)
		for i, v in pairs(context.nodes) do
			if vector.equals(pos, v) then
				context.nodes[i] = nil
				return
			end
		end
	end,
})

minetest.register_node("map_maker:area", {
	description = "Area node.", 
	drawtype = "nodebox",
	tiles = {"cs_files_area.png"},
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

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "mm:areas" then
		return
	end
	if fields.accept and (fields.str ~= "Eg: Sector A" or fields.str ~= " " or fields.str ~= "") then
		local pos = area_status[Name(player)].position
		local name = replace_spaces(fields.str)
		context.status[name] = {position = vector.new(pos), name = fields.str}
		storage:set_string("status", core.serialize(context.status))
		area_status[Name(player)] = nil
		core.set_node(pos, {name="air"})
	elseif fields.decline then
		core.chat_send_player(Name(player), core.colorize("#FF0000", "Declined."))
		local pos = area_status[Name(player)].position
		core.set_node(pos, {name="air"})
		area_status[Name(player)] = nil
	end
end)

minetest.register_node(":cs_core:counters", {
	description = "node\n Used for Counters Spawn.",
	drawtype="nodebox",
	paramtype = "light",
	walkable = false,
	tiles = {
		"default_wood.png",
	},
	groups = {oddly_breakable_by_hand=1,snappy=3},
	after_place_node = function(pos)
		table.insert(context.nodes, vector.new(pos))
		storage:set_string("nodes", minetest.write_json(context.nodes))
	end,
	on_destruct = function(pos)
		for i, v in pairs(context.nodes) do
			if vector.equals(pos, v) then
				context.nodes[i] = nil
				return
			end
		end
	end,
})
local function check_step()
	for _, pos in pairs(context.nodes) do
		if (minetest.get_node(pos).name ~= "cs_core:terrorists") or (minetest.get_node(pos).name ~= "cs_core:counters") then
			--minetest.log("error", "No node found!")
		end
	end

	minetest.after(1, check_step)
end
minetest.after(1, check_step)

local function get_nodes()
	local negative = nil
	local positive = nil
	for _, pos in pairs(context.nodes) do
		pos = vector.subtract(pos, context.center)

		if context.barrier_rot == 0 and pos.x < 0 or pos.z < 0 then
			negative = pos
		end

		if context.barrier_rot == 0 and pos.x > 0 or pos.z > 0 then
			positive = pos
		end
	end

	return negative, positive
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

local function max(a, b)
	if a > b then
		return a
	else
		return b
	end
end

--------------------------------------------------------------------------------
-- API --
--------------------------------------------------------------------------------

function map_maker.get_context()
	return context
end

function map_maker.put_a_bomb(player)
	nr = player:get_pos()
	nr.x = math.floor(nr.x)
	nr.y = math.floor(nr.y)
	nr.z = math.floor(nr.z)
	table.insert(context.areas, vector.new(nr))
	storage:set_string("areas", minetest.write_json(context.areas))
end
function map_maker.put_b_bomb(player)
	nr = player:get_pos()
	nr.x = math.floor(nr.x)
	nr.y = math.floor(nr.y)
	nr.z = math.floor(nr.z)
	table.insert(context.areas, vector.new(nr))
	storage:set_string("areas", minetest.write_json(context.areas))
end

function map_maker.emerge(name)
	local pos1, pos2 = to_2pos()
	map_maker.show_progress_formspec(name, "Emerging area...")
	cs_map.emerge_with_callbacks(name, pos1, pos2, function()
		map_maker.show_gui(name)
	end, map_maker.emerge_progress)
	return true
end

function map_maker.we_select(name)
	local pos1, pos2 = to_2pos()
	worldedit.pos1[name] = pos1
	worldedit.mark_pos1(name)
	worldedit.player_notify(name, "position 1 set to " .. minetest.pos_to_string(pos1))
	worldedit.pos2[name] = pos2
	worldedit.mark_pos2(name)
	worldedit.player_notify(name, "position 2 set to " .. minetest.pos_to_string(pos2))
end

function map_maker.we_import(name)
	local pos1 = worldedit.pos1[name]
	local pos2 = worldedit.pos2[name]
	if pos1 and pos2 then
		local size = vector.subtract(pos2, pos1)
		local r = max(size.x, size.z) / 2
		context.center = vector.divide(vector.add(pos1, pos2), 2)
		context.center.r = r
		context.center.h = size.y
		storage:set_string("center", minetest.write_json(context.center))
	end
end

function map_maker.set_meta(k, v)
	if v ~= context[k] then
		context[k] = v

		if type(v) == "number" then
			storage:set_int(k, v)
		else
			storage:set_string(k, v)
		end
	end
end

function map_maker.set_center(name, center)
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
	storage:set_string("center", minetest.write_json(context.center))
end

function map_maker.get_node_status()
	if #context.nodes > 2 then
		return "Too many nodes! (" .. #context.nodes .. "/2)"
	elseif #context.nodes < 2 then
		return "Place more nodes (" .. #context.nodes .. "/2)"
	else
		local negative, positive = get_nodes()
		if positive and negative then
			return "Nodes placed (" .. #context.nodes .. "/2)"
		else
			return "Place one node on each other side."
		end
	end
end

function map_maker.place_barriers(name)
	--print("HOLOGRAM1")
	map_maker.show_progress_formspec(name, "Emerging area...")
	--print("hologram9")
	local pos1, pos2 = to_2pos()
	cs_map.emerge_with_callbacks(name, pos1, pos2, function()
		--print("HOLOGRAM2")
		map_maker.show_progress_formspec(name,
			"Placing center barrier, this may take a while...")

		minetest.after(0.1, function()
			--print("hologram3")
			map_maker.show_progress_formspec(name,
				"Placing outer barriers, this may take a while...")
			minetest.after(0.1, function()
				--print("hologram4")
				cs_map.place_outer_barrier(context.center, context.barrier_r, context.center.h)
				map_maker.show_gui(name)
			end)
		end)
	end, map_maker.emerge_progress)
	
	
	return true
end

function map_maker.export(name)
	if #context.nodes ~= 2 then
		minetest.chat_send_all("You need to place two nodes in each sides!!")
		return
	end
	if #context.areas ~= 2 then
		minetest.chat_send_all("You need to place two areas in each sides for the bomb!!")
		return
	end

	map_maker.we_select(name)
	map_maker.show_progress_formspec(name, "Exporting...")

	local path = minetest.get_worldpath() .. "/schems/" .. context.mapname .. "/"
	minetest.mkdir(path)

	-- Reset mod_storage
	storage:set_string("center", "")
	storage:set_string("maptitle", "")
	storage:set_string("mapauthor", "")
	storage:set_string("mapname", "")
	storage:set_string("mapinitial", "")
	storage:set_string("barrier_rot", "")
	storage:set_string("barrier_r", "")

	-- Write to .conf
	local meta = Settings(path .. "map.conf")
	meta:set("name", context.maptitle)
	meta:set("author", context.mapauthor)
	if context.mapinitial ~= "" then
		meta:set("initial_stuff", context.mapinitial)
	end
	meta:set("rotation", context.barrier_rot)
	meta:set("r", context.center.r)
	meta:set("h", context.center.h)

	for _, var741 in pairs(context.nodes) do
		local pos = vector.subtract(var741, context.center)
		if context.barrier_rot == 0 then
			local old = vector.new(pos)
			pos.x = old.z
			pos.z = -old.x
		end

		local idx = pos.z > 0 and 1 or 2
		meta:set("team." .. idx, pos.z > 0 and "terrorist" or "counter")
		meta:set("team." .. idx .. ".color", pos.z > 0 and "terrorist" or "counter")
		meta:set("team." .. idx .. ".pos", minetest.pos_to_string(pos))
	end
	for _, var741 in pairs(context.areas) do
		local pos = vector.subtract(var741, context.center)
		if context.barrier_rot == 0 then
			local old = vector.new(pos)
			pos.x = old.z
			pos.z = -old.x
		end

		local idx = pos.z > 0 and 1 or 2
		meta:set("areas." .. idx, pos.z > 0 and "a" or "b")
		--meta:set("areas." .. idx .. ".color", pos.z > 0 and "terrorist" or "counter")
		meta:set("areas." .. idx .. ".pos", minetest.pos_to_string(pos))
	end
	local status_table = {}
	for name, tabled in pairs(context.status) do
		local pos = vector.subtract(tabled.position, context.center)
		if context.barrier_rot == 0 then
			local old = vector.new(pos)
			pos.x = old.z
			pos.z = -old.x
		end
		
		status_table[name] = {
			pos = minetest.pos_to_string(pos),
			str = tabled.name
		}
		
		--table.insert(status_table, {})
		--[[
		meta:set("status." .. name, tabled.name)
		meta:set("status." .. name .. ".pos", minetest.pos_to_string(pos))
		meta:set("status." .. name .. ".str", tabled.name)--]]
	end
	
	meta:set("status", core.serialize(status_table))
	meta:write()

	minetest.after(0.1, function()
		local filepath = path .. "map.mts"
		if minetest.create_schematic(worldedit.pos1[name], worldedit.pos2[name],
				worldedit.prob_list[name], filepath) then
			minetest.chat_send_all("Exported " .. context.mapname .. " to " .. path)
			minetest.close_formspec(name, "")
		else
			minetest.chat_send_all("Failed!")
			map_maker.show_gui(name)
		end
	end)
	return
end
