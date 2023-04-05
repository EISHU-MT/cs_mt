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