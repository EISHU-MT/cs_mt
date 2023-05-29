call.register_on_player_join_team(function(player, team)
	if (not has_bomb) and csgo.team.terrorist.count - 1 == 0 and team == "terrorist" then
		has_bomb = player
		Inv(player):add_item("main", ItemStack("bomb"))
	end
end)