function csgo.off_movement()
	for __, player in pairs(core.get_connected_players()) do
		
		local pname = player:get_player_name()
		if not csgo.spect[pname] == true then
		player:set_physics_override({
			--gravity = 1090
			speed = 0,
			jump = 0
			
		})
		end
		
	end
end
function csgo.on_movement()
	for __, player in pairs(core.get_connected_players()) do
		
		local pname = player:get_player_name()
		if not csgo.spect[pname] == true then
		player:set_physics_override({
			--gravity = 1090
			speed = 1,
			jump = 1
		})
		end
		
	end
end