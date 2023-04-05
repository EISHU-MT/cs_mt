function cdoor.scan_for_players(pos) 
	local a = minetest.get_objects_inside_radius(pos, clua.get_int("radious", clua.get_table_value("cs_decor")))
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
