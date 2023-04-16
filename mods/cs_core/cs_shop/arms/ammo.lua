minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:ammo" then
		return
	end
	if fields.diemm then
		cs_shop.buy_ammo("10mm", player)
	end
	if fields.winchester then
		cs_shop.buy_ammo("308winchester", player)
	end
	if fields.magnum then
		cs_shop.buy_ammo("357", player)
	end
	if fields.cheytac then
		cs_shop.buy_ammo("408cheytac", player)
	end
	if fields.mmg then
		cs_shop.buy_ammo("40mm", player)
	end
	if fields.magnumr then
		cs_shop.buy_ammo("44", player)
	end
	if fields.acp then
		cs_shop.buy_ammo("45acp", player)
	end
	if fields.seimm then
		cs_shop.buy_ammo("556mm", player)
	end
	if fields.sietemm then
		cs_shop.buy_ammo("762mm", player)
	end
	if fields.nueve then
		cs_shop.buy_ammo("9mm", player)
	end
	if fields.gauge then
		cs_shop.buy_ammo("shell", player)
	end
	if fields.ae then
		cs_shop.buy_ammo("50ae", player)
	end
end)