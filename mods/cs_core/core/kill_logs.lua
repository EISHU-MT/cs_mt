kills = {
    terrorist = {},
    counter = {},
    spectator = {
        unit = function() end
    }
}

call.register_on_new_matches(function()
    core.after(5, function()
        for pname, stats in pairs(kills.terrorist) do
            stats.kills = 0
            stats.deaths = 0
        end
        for pname, stats in pairs(kills.counter) do
            stats.kills = 0
            stats.deaths = 0
        end
    end)
end)

call.register_on_player_join_team(function(pname, team)
    kills[team][pname] = {kills = 0, deaths = 0}
end)

call.register_on_kill_player(function(player, enemy, enemyt, playert)
	if player and enemy and enemyt and playert then
	    if enemy ~= "reason:drown" and enemy ~= "reason:fall" and enemy ~= "reason:table" then
		if player and enemy and enemyt and playert then
		    kills[enemyt][enemy].kills = kills[enemyt][enemy].kills + 1
		    kills[playert][player].deaths = kills[playert][player].deaths + 1
		end
	    else
		if playert and player then
			kills[playert][player].deaths = kills[playert][player].deaths + 1
		end
	    end
	end
end)






