cdoor = {}
function cdoor.scan_for_players(pos) 
	local a = minetest.get_objects_inside_radius(pos, 2)
	if next(a) == nil then
		return false
	end

	local every_player = true
	for _, a1 in pairs(a) do
		-- "" is returned if it is not a player; "" ~= nil; so only handle objects with foundname ~= ""
		local foundname = a1:get_player_name()
		if foundname ~= "" then
			return true
		end
	end
end

doors.register("door_auto", {
		tiles = {"cs_files_door.png"},
		description = ("Automatic door"),
		inventory_image = "cs_files_door_inv.png",
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		gain_open = 0.2,
		gain_close = 0.2,
})

minetest.register_abm({
	nodenames = {"doors:door_auto_c"},
	interval = 0.1,
	chance = 10000000000000000000000000,
	action = function(pos)
		if not cdoor.scan_for_players(pos) then
			local door = doors.get(pos)
			door:close()
		end
	end,
})
minetest.register_abm({
	nodenames = {"doors:door_auto_a"},
	interval = 0.1,
	chance = 10000000000000000000000000, -- ACHOO
	action = function(pos)
		if cdoor.scan_for_players(pos) then
			local door = doors.get(pos)
			door:open()
		end
	end,
})
