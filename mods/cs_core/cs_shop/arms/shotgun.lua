minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:shotgun" then
		return
	end
	local name = player:get_player_name()
	if fields.remi then
		cs_shop.buy_arm("rangedweapons:remington", player)
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
	if fields.spas then
		cs_shop.buy_arm("rangedweapons:spas12", player)
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
	if fields.awp then
		cs_shop.buy_arm("rangedweapons:awp", player)
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
	if fields.beneli then
		cs_shop.buy_arm("rangedweapons:benelli", player)
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
	if fields.jackh then
		cs_shop.buy_arm("rangedweapons:jackhammer", player)
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
	if fields.aa then
		cs_shop.buy_arm("rangedweapons:aa12", player)
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
end)
