minetest.register_on_joinplayer(function(player)
	if not has_bomb then
		has_bomb = player:get_player_name()
		Inv(player):add_item("main", ItemStack("bomb"))
	end
end)