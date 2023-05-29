function maps.update_core()
	for name, def in pairs(maps.reg_maps) do
		if name and def then
			table.insert(maps.maps_name, name)
		end
	end
end
function maps.select_map()
	local maps_numb = #maps.maps_name
	local random_numb = math.random(1, maps_numb)
	if maps.next_map and maps.next_map.name ~= nil then
		return maps.next_map
	else
		local map_name = maps.maps_name[random_numb]
		local map_def = maps.reg_maps[map_name]
		return map_def
	end
end
function maps.place_map(map_def)
	if map_def and type(map_def) == "table" then
		print(dump(map_def))
		maps.emerge_with_callbacks(nil, map_def.pos1, map_def.pos2, function()
			log("info", "Placing map: "..map_def.name)
			local bool = minetest.place_schematic(map_def.pos1, map_def.mcore, map_def.rotation == "z" and "0" or "90")
			assert(bool, "Something failed!: Map core: 'core.mts' dont exist, or may it was corrupted!")
			log("info", "ON-PLACE-MAP: Map light areas fix starting")
			local function fix_light(...) core.fix_light(...) log("action", "ON-PLACE-MAP: Map light areas fix complete") end
			core.after(5, fix_light, map_def.pos1, map_def.pos2)
		end, nil)
	end
end

function maps.new_map()
	if cmaps.enable == true then
		return -- Return, because map maker is on
	end
	local def = maps.select_map()
	maps.place_map(def)
	RunCallbacks(maps.on_load, def)
	maps.current_map = def
	maps.update_env()
	
	-- Terrorists Spawn
	function terrorists_spawn()
		local terroristsspawn = def.teams.terrorist
		return terroristsspawn
	end
	-- (A) bomb area
	function a_bomb_area()
		local a = def.bareas.a or def.bareas.b
		return a
	end
	-- (B) bomb area
	function b_bomb_area()
		local b = def.bareas.b or def.bareas.a
		return b
	end
	-- Counters Spawn
	function counters_spawn()
		local countersspawn = def.teams.counter
		return countersspawn
	end
	-- Spectators spawn
	function spectators_spawn()
		spect = def.teams.counter -- XD they will spawn in a wall
		return spect
	end
	
	function ask_for_bomb() return def.bareas.a ~= nil and def.bareas.b ~= nil end
end

-- Areas control
function maps.is_on_interior(pos, rpos1, rpos2)
	--rpos1 = Minimun coordinates (Depends on Y)
	--rpos2 = Maximun coordinates (Depends on Y)
	-- Forming like corners to form an cube (with different coordinates)
	return pos.x >= rpos1.x and pos.x <= rpos2.x
		and pos.y >= rpos1.y and pos.y <= rpos2.y
		and pos.z >= rpos1.z and pos.z <= rpos2.z
end
function maps.get_status_of_areas()
	return type(current_map.area_status) == "table"
end
function maps.get_name_of_pos(pos)
	if maps.get_status_of_areas() then
		for i, val in pairs(current_map.area_status) do
			if val.not_radius ~= true then
				if vector.distance(val.pos, pos) <= val.rad then
					return val.str or "--"
				end
			elseif val.not_radius == true then
				if maps.is_on_interior(pos, val.pos1, val.pos2) then
					return val.str or "--"
				end
			end
		end
	else
		return "--"
	end
	return "--"
end

minetest.register_node("mcore:ign", {
	description = "Ignore Node.", 
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable     = true,
	pointable    = false,
	diggable     = false,
	buildable_to = false,
	air_equivalent = true,
	groups = {immortal = 1},
})
minetest.register_node("mcore:stone", {
	description = "Wall Stone\n ONLY USE IN BARRIERS", 
	tiles = {"bound.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable     = true,
	pointable    = true,
	diggable     = false,
	buildable_to = false,
	air_equivalent = true,
	groups = {immortal = 1},
})
minetest.register_node("mcore:ind_glass", {
	description = "Wall Glass\n ONLY USE IN BARRIERS\n ", 
	tiles = {"wall.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable     = true,
	pointable    = true,
	diggable     = false,
	buildable_to = false,
	air_equivalent = true,
	groups = {immortal = 1},
})

