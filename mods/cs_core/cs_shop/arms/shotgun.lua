minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:shotgun" then
		return
	end
	if fields.remi then
		cs_shop.buy_arm("rangedweapons:remington", player)
	end
	if fields.spas then
		cs_shop.buy_arm("rangedweapons:spas12", player)
	end
	if fields.awp then
		cs_shop.buy_arm("rangedweapons:awp", player)
	end
	if fields.beneli then
		cs_shop.buy_arm("rangedweapons:benelli", player)
	end
	if fields.jackh then
		cs_shop.buy_arm("rangedweapons:jackhammer", player)
	end
	if fields.aa then
		cs_shop.buy_arm("rangedweapons:aa12", player)
	end
end)
