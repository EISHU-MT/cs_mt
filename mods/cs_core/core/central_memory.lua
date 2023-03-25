-- This auto-repairs csgo when the menu of users is broken, and it recovers back
--
-- BY EISHU
--
function temporal5()
	list = core.get_connected_players()
	core.after(2, temporal5)
end
core.after(0.5, temporal5)
-- check by connected players.
function ccc(player)
	if player then
		--local list = core.get_connected_players()
		for _, str in pairs(list) do
			str2 = str:get_player_name()
			--error(str.." null "..str2)
			if str2 == player then
				return true
			end
		end
	end
end

temporal = {}
timeeee = 0 
minetest.register_globalstep(function(dtime)

	for pname, __ in pairs(csgo.team.terrorist.players) do
		if pname then
			--print(pname)
			player = core.get_player_by_name(pname)
			if pname then
			if ccc(pname) then
				empty() -- Ignore if the player is online
				--core.debug("green", "Fixed player: "..pname, "CS:GO Core")
			else
				cs_core.log("warn", "Non-exixsting player found: "..pname)
				he_team = "terrorist"
				csgo.op[pname] = nil
				csgo.pt[pname] = nil
				csgo.online[pname] = nil
				csgo.spect[pname] = nil
				csgo.pot[pname] = nil
				csgo.team[he_team].count = csgo.team[he_team].count - 1
				
				--main_hud.set_main_terrorist(csgo.team[he_team].count)
				
				csgo.team[he_team].players[pname] = nil
			end
			end
		end
	end
	
	for pname, __ in pairs(csgo.team.counter.players) do
		if pname then
			--print(pname)
			player = core.get_player_by_name(pname)
			if pname then
			if ccc(pname) then
				empty() -- Ignore if the player is online
				--core.debug("green", "Fixed player: "..pname, "CS:GO Core")
			else
				cs_core.log("warn", "Non-exixsting player found: "..pname)
				he_team = "counter"
				csgo.op[pname] = nil
				csgo.pt[pname] = nil
				csgo.online[pname] = nil
				csgo.spect[pname] = nil
				csgo.pot[pname] = nil
				csgo.team[he_team].count = csgo.team[he_team].count - 1
				
				-- DEPRECATED
				--main_hud.set_main_counter(csgo.team[he_team].count)
				
				csgo.team[he_team].players[pname] = nil
			end
			end
		end
	end
	

end)
