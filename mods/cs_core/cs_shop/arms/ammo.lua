minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:ammo" then
		return
	end
	local name = player:get_player_name()
	if fields.diemm then
		cs_shop.buy_ammo("10mm", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.winchester then
		cs_shop.buy_ammo("308winchester", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.magnum then
		cs_shop.buy_ammo("357", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.cheytac then
		cs_shop.buy_ammo("408cheytac", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.mmg then
		cs_shop.buy_ammo("40mm", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.magnumr then
		cs_shop.buy_ammo("44", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.acp then
		cs_shop.buy_ammo("45acp", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.seimm then
		cs_shop.buy_ammo("556mm", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.sietemm then
		cs_shop.buy_ammo("762mm", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.nueve then
		cs_shop.buy_ammo("9mm", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.gauge then
		cs_shop.buy_ammo("shell", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if fields.ae then
		cs_shop.buy_ammo("50ae", player)
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
end)