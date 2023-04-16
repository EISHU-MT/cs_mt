minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:pistol" then
		return
	end
	-- Pistols part
	if fields.makarov then
		cs_shop.buy_arm("rangedweapons:makarov", player)
	end
	if fields.luger then
		cs_shop.buy_arm("rangedweapons:luger", player)
	end
	if fields.beretta then
		cs_shop.buy_arm("rangedweapons:beretta", player)
	end
	if fields.m1991 then
		cs_shop.buy_arm("rangedweapons:m1991", player)
	end
	if fields.glock then
		cs_shop.buy_arm("rangedweapons:glock17", player)
	end
	if fields.deagle then
		cs_shop.buy_arm("rangedweapons:deagle", player)
	end
end)
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:smg" then
		return
	end
	-- SMGs part
	if fields.steyr then
		cs_shop.buy_arm("rangedweapons:tmp", player)
	end
	if fields.tec9 then
		cs_shop.buy_arm("rangedweapons:tec9", player)
	end
	if fields.usi then
		cs_shop.buy_arm("rangedweapons:uzi", player)
	end
	if fields.kriss then
		cs_shop.buy_arm("rangedweapons:kriss_sv", player)
	end
end)