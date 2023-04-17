minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:pistol" then
		return
	end
	local name = player:get_player_name()
	-- Pistols part
	if fields.makarov then
		cs_shop.buy_arm("rangedweapons:makarov", player)
		minetest.show_formspec(name, "cs_shop:pistol", cs_shop.pistol(name))
	end
	if fields.luger then
		cs_shop.buy_arm("rangedweapons:luger", player)
		minetest.show_formspec(name, "cs_shop:pistol", cs_shop.pistol(name))
	end
	if fields.beretta then
		cs_shop.buy_arm("rangedweapons:beretta", player)
		minetest.show_formspec(name, "cs_shop:pistol", cs_shop.pistol(name))
	end
	if fields.m1991 then
		cs_shop.buy_arm("rangedweapons:m1991", player)
		minetest.show_formspec(name, "cs_shop:pistol", cs_shop.pistol(name))
	end
	if fields.glock then
		cs_shop.buy_arm("rangedweapons:glock17", player)
		minetest.show_formspec(name, "cs_shop:pistol", cs_shop.pistol(name))
	end
	if fields.deagle then
		cs_shop.buy_arm("rangedweapons:deagle", player)
		minetest.show_formspec(name, "cs_shop:pistol", cs_shop.pistol(name))
	end
end)
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:smg" then
		return
	end
	local name = player:get_player_name()
	-- SMGs part
	if fields.steyr then
		cs_shop.buy_arm("rangedweapons:tmp", player)
		minetest.show_formspec(name, "cs_shop:smg", cs_shop.smg(name))
	end
	if fields.tec9 then
		cs_shop.buy_arm("rangedweapons:tec9", player)
		minetest.show_formspec(name, "cs_shop:smg", cs_shop.smg(name))
	end
	if fields.usi then
		cs_shop.buy_arm("rangedweapons:uzi", player)
		minetest.show_formspec(name, "cs_shop:smg", cs_shop.smg(name))
	end
	if fields.kriss then
		cs_shop.buy_arm("rangedweapons:kriss_sv", player)
		minetest.show_formspec(name, "cs_shop:smg", cs_shop.smg(name))
	end
end)