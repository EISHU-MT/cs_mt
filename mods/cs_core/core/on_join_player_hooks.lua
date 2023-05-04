call.register_on_player_join_team(function(player)
	if (not has_bomb) and csgo.team.terrorist.count - 1 == 0 then
		has_bomb = player
		Inv(player):add_item("main", ItemStack("bomb"))
	end
end)