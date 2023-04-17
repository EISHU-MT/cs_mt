minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:rifle" then
		return
	end
	local name = player:get_player_name()
	if fields.awp then
		cs_shop.buy_arm("rangedweapons:awp", player)
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
	if fields.svd then
		cs_shop.buy_arm("rangedweapons:svd", player)
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
	if fields.m200 then
		cs_shop.buy_arm("rangedweapons:m200", player)
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
	if fields.m16 then
		cs_shop.buy_arm("rangedweapons:m16", player)
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
	if fields.g36 then
		cs_shop.buy_arm("rangedweapons:g36", player)
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
	if fields.ak47 then
		cs_shop.buy_arm("rangedweapons:ak47", player)
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
	if fields.scar then
		cs_shop.buy_arm("rangedweapons:scar", player)
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
end)