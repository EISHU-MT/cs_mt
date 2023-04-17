minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:grenade" then
		return
	end
	local name = player:get_player_name()
	if fields.nbomb then
		cs_shop.buy_grenade("grenades:frag", player, "frag")
		minetest.show_formspec(name, "cs_shop:grenade", cs_shop.grenade(name))
	end
	if fields.flashbang then
		cs_shop.buy_grenade("grenades:flashbang", player, "flashbang")
		minetest.show_formspec(name, "cs_shop:grenade", cs_shop.grenade(name))
	end
	if fields.smoke then
		cs_shop.buy_grenade("grenades:smoke", player, "smoke")
		minetest.show_formspec(name, "cs_shop:grenade", cs_shop.grenade(name))
	end
	if fields.sfrag then
		cs_shop.buy_grenade("grenades:frag_sticky", player, "frag_sticky")
		minetest.show_formspec(name, "cs_shop:grenade", cs_shop.grenade(name))
	end
end)