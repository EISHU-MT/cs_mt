call.register_on_player_join_team(function(player, team)
	if ((not has_bomb) or (not Player(has_bomb))) and csgo.team.terrorist.count - 1 == 0 and team == "terrorist" then
		has_bomb = player
		Inv(player):add_item("main", ItemStack("bomb"))
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