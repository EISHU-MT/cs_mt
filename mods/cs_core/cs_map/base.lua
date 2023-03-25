function cs_map.place_base(color, pos)
	-- Spawn base
	for x = pos.x - 2, pos.x + 2 do
	for z = pos.z - 2, pos.z + 2 do
		minetest.set_node({ x = x, y = pos.y - 1, z = z },
			{ name = "cs_map:cobble" })
	end
	end



end


