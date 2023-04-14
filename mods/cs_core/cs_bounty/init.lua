calified_players = {}
ruled_players    = {}
call.register_on_player_join_team(function(pname, team)
	if pname and team then
		calified_players[pname] = 0
		ruled_players[pname] = false
	end
end)
function send_all(msg, pl, c)
	for _, a in pairs(core.get_connected_players()) do
		local b = a:get_player_name()
		if a ~= pl then
			core.chat_send_player(b, core.colorize(c, msg))
		end
	end
end
call.register_on_kill_player(function(player, enemy, enemyt, playert)
	if enemy == "reason:drown" or enemy == "reason:fall" or enemy == "reason:table" then
		if ruled_players[player] then
			send_all("Missed Bounty of "..player.."!", player, "#FF3D00")
		end
		return
	end
	if kills[enemyt][enemy].kills > 20 and kills[enemyt][enemy].kills < 30 then
		ruled_players[enemy] = true
		if calified_players[enemy] ~= 5 then
			calified_players[enemy] = 2
			send_all("Player "..enemy.." had a bounty of $200", enemy, "#FFB500")
		end
	elseif kills[enemyt][enemy].kills > 30 and kills[enemyt][enemy].kills < 40 then
		ruled_players[enemy] = true
		if calified_players[enemy] ~= 5 then
			calified_players[enemy] = 3
			send_all("Player "..enemy.." had a bounty of $300", enemy, "#FFB500")
		end
	elseif kills[enemyt][enemy].kills > 40 and kills[enemyt][enemy].kills < 50 then
		ruled_players[enemy] = true
		if calified_players[enemy] ~= 5 then
			calified_players[enemy] = 4
			send_all("Player "..enemy.." had a bounty of $400", enemy, "#FFB500")
		end
	elseif kills[enemyt][enemy].kills > 50 then
		ruled_players[enemy] = true
		if calified_players[enemy] ~= 5 then
			calified_players[enemy] = 5
			send_all("Player "..enemy.." had a bounty of $500", enemy, "#FFB500")
		end
	end
	if ruled_players[player] then
		if calified_players[player] then
			local a = tostring(calified_players[player])
			local b = a.."00"
			local c = tonumber(b)
			send_all("Player "..enemy.." won: + 1 BountyKills +"..tostring(c).."$", "-ae/1", "#FFB500")
			bank.player_add_value(enemy, c)
		end
	end
end)