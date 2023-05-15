local maintained_players = {}
function csgo.off_movement()
	for __, player in pairs(core.get_connected_players()) do
		
		local pname = player:get_player_name()
		if not csgo.spect[pname] == true then
			maintained_players[pname] = player:get_physics_override()
			player:set_physics_override({
				--gravity = 1090
				speed = 0.2,
				jump = 0.2
				
			})
		end
		
	end
end
function csgo.on_movement()
	for __, player in pairs(core.get_connected_players()) do
		
		local pname = player:get_player_name()
		if not maintained_players[pname] then
			maintained_players[pname] = player:get_physics_override()
		end
		if not csgo.spect[pname] == true then
			player:set_physics_override({
				--gravity = 1090
				speed = maintained_players[pname].speed or 1,
				jump = maintained_players[pname].jump or 1
			})
			maintained_players[pname] = nil
		end
		
	end
end