local function on_step()
	for _, player in pairs(core.get_connected_players()) do
		local control = player:get_player_control()
		if control.sneak and csgo.pot[Name(player)] and csgo.pot[Name(player)] ~= "spectator" then
			local properties = player:get_properties()
			properties.makes_footstep_sound = false
			player:set_properties(properties)
		elseif csgo.pot[Name(player)] and csgo.pot[Name(player)] ~= "spectator" then
			local properties = player:get_properties()
			properties.makes_footstep_sound = true
			player:set_properties(properties)
		end
	end
end

core.register_globalstep(on_step)
