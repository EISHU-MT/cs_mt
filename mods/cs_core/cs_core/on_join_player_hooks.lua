call.register_on_player_join_team(function(player, team)
	if ((not has_bomb) or (not Player(has_bomb))) and csgo.team.terrorist.count - 1 == 0 and team == "terrorist" then
		has_bomb = player
		Inv(player):add_item("main", ItemStack("bomb"))
	end
	if type(temporalhud) == "table" then
		temporalhud[player] = Player(player):hud_add({
			hud_elem_type = "waypoint",
			number = 0xFF6868,
			name = "The bomb was dropped here! dropped by ".. dropt_bomb_handler,
			text = "m",
			world_pos = dropt_bomb_pos
		})
	end
end)

local function hks(dtime)
	for pname in pairs(csgo.team.spectator.players) do
		if Player(pname) then
			Player(pname):set_armor_groups({immortal=1})
		end
	end
end

core.register_globalstep(hks)