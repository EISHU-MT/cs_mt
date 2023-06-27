kills = {
	
}

call.registered_on_add_killer = {}

call.register_on_add_killer = function(func)
	table.insert(call.registered_on_add_killer, func or function() end)
end

call.register_on_new_matches(function()
	core.after(5, function()
		for pname, stats in pairs(kills) do
			if type(stats) == "table" then
				stats.kills = 0
				stats.deaths = 0
				stats.score = 0
			end
		end
	end)
end)

function register_kill(player, killer)
	for i = 1, #call.registered_on_add_killer do
		call.registered_on_add_killer[i](player or "", killer or "", kills[player] or {kills = 0, deaths = 0, team = ""})
	end
end

function kills.add_to(pname, team)
	kills[pname] = {kills = 0, deaths = 0, team = team, score = 0}
	bounty[pname] = 0
end

call.register_on_player_join_team(function(pname, team)
	if team == "spectator" then return end
	kills.add_to(pname, team)
end)

call.register_on_kill_player(function(player, enemy, enemyt, playert)
	if player and enemy and enemyt and playert then
		if enemy ~= "reason:drown" and enemy ~= "reason:fall" and enemy ~= "reason:table" then
			if player and enemy and enemyt and playert then
				kills[enemy].kills = kills[enemy].kills + 1
				kills[player].deaths = kills[player].deaths + 1
				register_kill(Name(player), Name(enemy))
			end
		else
			if player then
				kills[player].deaths = kills[player].deaths + 1
				register_kill(Name(player), "")
			end
		end
	elseif player then
		kills[player].deaths = kills[player].deaths + 1
		register_kill(Name(player), "")
	end
end)



csgoc = table.copy(call)


