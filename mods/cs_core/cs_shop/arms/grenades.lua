minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:grenade" then
		return
	end
	if fields.nbomb then
		cs_shop.buy_grenade("grenades:frag", player, "frag")
	end
	if fields.flashbang then
		cs_shop.buy_grenade("grenades:flashbang", player, "flashbang")
	end
	if fields.smoke then
		cs_shop.buy_grenade("grenades:smoke", player, "smoke")
	end
	if fields.sfrag then
		cs_shop.buy_grenade("grenades:frag_sticky", player, "frag_sticky")
	end
end)