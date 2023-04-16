minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:rifle" then
		return
	end
	if fields.awp then
		cs_shop.buy_arm("rangedweapons:awp", player)
	end
	if fields.svd then
		cs_shop.buy_arm("rangedweapons:svd", player)
	end
	if fields.m200 then
		cs_shop.buy_arm("rangedweapons:m200", player)
	end
	if fields.m16 then
		cs_shop.buy_arm("rangedweapons:m16", player)
	end
	if fields.g36 then
		cs_shop.buy_arm("rangedweapons:g36", player)
	end
	if fields.ak47 then
		cs_shop.buy_arm("rangedweapons:ak47", player)
	end
	if fields.scar then
		cs_shop.buy_arm("rangedweapons:scar", player)
	end
end)