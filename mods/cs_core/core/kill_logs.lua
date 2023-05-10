kills = {
	
}

call.register_on_new_matches(function()
	core.after(5, function()
		for pname, stats in pairs(kills) do
			stats.kills = 0
			stats.deaths = 0
		end
	end)
end)

call.register_on_player_join_team(function(pname, team)
    kills[pname] = {kills = 0, deaths = 0, team = team}
end)

call.register_on_kill_player(function(player, enemy, enemyt, playert)
	if player and enemy and enemyt and playert then
		if enemy ~= "reason:drown" and enemy ~= "reason:fall" and enemy ~= "reason:table" then
			if player and enemy and enemyt and playert then
				kills[enemy].kills = kills[enemy].kills + 1
				kills[player].deaths = kills[player].deaths + 1
			end
		else
			if player then
				kills[player].deaths = kills[player].deaths + 1
			end
		end
	elseif player then
		kills[player].deaths = kills[player].deaths + 1
	end
end)






