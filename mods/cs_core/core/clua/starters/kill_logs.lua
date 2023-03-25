kills = {
    terrorist = {
        exampleuserEULA = {kills = 1, deaths = 0, name = "exampleuserEULA"}
    },
    counter = {
        exampleuserEULA2 = {kills = 50, deaths = 5, name = "exampleuserEULA2"}
    },
    spectator = {
        unit = function()
            error("spectators cant have kills/deaths!")
        end
    }
}
--core.after(1, function()
	    call.register_on_new_matches(function()
		core.after(5, function()
		    for pname in pairs(kills.terrorist) do
		        kills.terrorist[pname] = {kills = 0, deaths = 0}
		    end
		    for pname in pairs(kills.counter) do
		        kills.counter[pname] = {kills = 0, deaths = 0}
		    end
		end)
	    end)
    
    call.register_on_player_join_team(function(pname, team)
        if pname and team then
            kills[team][pname] = {kills = 0, deaths = 0}
        end
    end)

    call.register_on_kill_player(function(player, enemy, enemyt, playert)
        if player and enemy and enemyt and playert then
            kills[enemyt][enemy].kills = kills[enemyt][enemy].kills + 1
            kills[playert][player].kills = kills[playert][player].deaths + 1
        end
    end)
--end)