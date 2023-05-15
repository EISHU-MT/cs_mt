died = {}
cs_kill = {
	terrorist = {
		killed_players = {},
		alive_players = {},
	},
	counter = {
		killed_players = {},
		alive_players = {},
	},
}
--[[

--]]

local S = minetest.get_translator("cs_kill")
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	pname = hitter:get_player_name()
	victim = player:get_player_name()
	if not pname and not victim then
		return
	end
	
	if (cs_core.ask_can_do_damage(pname) == false) or csgo.spect[pname] then
		hud_events.new(hitter, {
			text = S("You can't damage others players!!"),
			color = "warning",
			quick = true,
		})
		return true
	end
	
	if (csgo.pot[pname] == csgo.pot[victim]) and not (pname == victim) then
		hud_events.new(hitter, {
			text = S("@1 its your teammate! ( ! )", victim),
			color = "warning",
			quick = true,
		})
		local enable_it = minetest.settings:get_bool("cs_core.enable_friend_shot", false)
		if enable_it ~= true then
			return false
		else
			return true
		end
	end
	if cs_match.commenced_match ~= true then
		hud_events.new(hitter, {
			text = S("You can't damage others players!!"),
			color = "warning",
			quick = true,
		})
		return true
	end
end)
function cs_kill.translate_to_real_damage(damage)
	if not damage then
		return 0
	end
	local a1 = tostring(damage)

	local a2 = string.sub(a1, 2)

	local a3 = tonumber(a2)

	return a3
end
function cs_kill.run_callbacks(...)
	for i = 1, #cb.registered_on_kill do
		cb.registered_on_kill[i](...)
	end
end

local dead_ent = {
	hp_max = 100,
	--eye_height = 1.625,
	physical = false,
	collide_with_objects = true,
	collisionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },  -- default
	selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = false },
	pointable = false,
	visual = "mesh",
	visual_size = {x = 1, y = 1, z = 1},
	mesh = "empty.b3d",
	textures = {},
	colors = {},
	use_texture_alpha = false,
	spritediv = {x = 1, y = 1},
	initial_sprite_basepos = {x = 0, y = 0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = 0,
	stepheight = 0,
	automatic_face_movement_dir = 0.0,
	automatic_face_movement_max_rotation_per_sec = -1,
	backface_culling = true,
	glow = 1,
	nametag = "",
	infotext = "(DIED)",
	static_save = true,
	damage_texture_modifier = "",
	shaded = true,
	show_on_minimap = false,
}


minetest.register_on_player_hpchange(function(player, hp_ch, reason)
	if cs_match.commenced_match == true then --Be sure if the match is continued or a fail.
		local hp_change = cs_kill.translate_to_real_damage(hp_ch)
		if not hp_change then
			return true
		end
		local pname
		if reason.object then
			pname = reason.object:get_player_name()
		end
		
		local victim = player:get_player_name()
		
		
		if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 and csgo.pot[victim] and csgo.pot[victim] ~= "spectator" then
			died_players[player:get_player_name()] = minetest.add_entity(player:get_pos(), "cs_player:dead_ent")
			local new_table = table.copy(dead_ent)
			local tex
			if csgo.pot2[Name(player)] == "terrorist" then
				tex = "red.png"
			elseif csgo.pot2[Name(player)] == "counter" then
				tex = "blue.png"
			else
				tex = "character.png"
			end
			new_table.textures = {tex}
			new_table.visual_size = {x = 1, y = 1, z = 1}
			died_players[player:get_player_name()]:set_properties(new_table)
			died_players[player:get_player_name()]:set_animation({x = 162, y = 166}, 15, 0)
			--player_set_animation(player, "lay")
			
			local value5 = csgo.team[csgo.pot[victim]].count - 1
			function empty() end
			if victim and csgo.pot[victim] and csgo.pot[victim] ~= "spectator" then
				if value5 <= 0 then
					print()
				else
					ccore[victim] = csgo.pot2[victim]
				end
			end
		end
		
		
		
		if reason.type == "punch" and reason.object then
			if not victim or not pname then
				return
			end
			if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 and reason.object then
				if csgo.pot[victim] == csgo.pot[pname] then -- They suicide and win, this is not ok >:(
					if csgo.team[csgo.pot[victim]].count - 1 < 0 and csgo.team[csgo.enemy_team(csgo.pot[victim])].count == 1 then
						local t = csgo.enemy_team(csgo.pot[victim])
						
						local random = Randomise("Select random", {"The last alive player is: "..victim, "The team "..csgo.enemy_team(csgo.pot[victim]).." had only 1 player!"})
						
						annouce.winner(t, random)
						cs_match.finish_match(csgo.pot[pname])
						cs_kill.run_callbacks(victim, pname, csgo.pot[pname], csgo.pot[victim])
						
					elseif csgo.team[csgo.pot[victim]].count - 1 < 0 then
						local t = csgo.enemy_team(csgo.pot[victim])
						local random = Randomise("Select random", {"The last player that do suicide is: "..victim, "The team "..t.." did his job"})
						annouce.winner(t, random)
						cs_match.finish_match(csgo.pot[pname])
						cs_kill.run_callbacks(victim, nil, nil, csgo.pot[victim])
					else
						if died[victim] ~= true then 
							if cs_match.commenced_match ~= false then
								local a1 = reason.object:get_wielded_item()
								local image = a1:get_definition().inventory_image or "cs_files_hand.png"
								cs_kh.add(reason.object:get_player_name(), player:get_player_name(), image, "", csgo.pot[victim])
								
								died[victim] = true
								cs_kill.run_callbacks(victim, nil, nil, csgo.pot[victim])
								
								ccore[victim] = csgo.pot[victim]
								csgo.blank(victim, csgo.pot[victim])
								csgo.spectator(victim)
								csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
							end
						end
					end
					return
				else
					if csgo.team[csgo.pot[victim]].count - 1 == 0 and csgo.team[csgo.pot[pname]].count == 1 then
						local random = Randomise("Select random", {"The last alive player is: "..pname, "the team "..csgo.pot[pname].." had only 1 player!", "wajaaaa"})
						annouce.winner(csgo.pot[pname], random)
						cs_match.finish_match(csgo.pot[pname])
						cs_kill.run_callbacks(victim, pname, csgo.pot[pname], csgo.pot[victim])
					elseif csgo.team[csgo.pot[victim]].count - 1 == 0 and victim and csgo.pot[pname] then
						local random = Randomise("Select random", {"The last killed player is: "..victim, "the team "..csgo.pot[pname].." did his job", "wajaaa"})
						annouce.winner(csgo.pot[pname], random)
						cs_match.finish_match(csgo.pot[pname])
						cs_kill.run_callbacks(victim, pname, csgo.pot[pname], csgo.pot[victim])
					else
						if died[victim] ~= true then 
							if cs_match.commenced_match ~= false then
								local a1 = reason.object:get_wielded_item()
								local image = a1:get_definition().inventory_image or "cs_files_hand.png"
								cs_kh.add(reason.object:get_player_name(), player:get_player_name(), image, "", csgo.pot[victim])
								
								died[victim] = true
								cs_kill.run_callbacks(victim, pname, csgo.pot[pname], csgo.pot[victim])
								
								ccore[victim] = csgo.pot[victim]
								csgo.blank(victim, csgo.pot[victim])
								csgo.spectator(victim)
								csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
							end
						end
					end
				end
			end
		elseif reason.type == "fall" then --
			if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 then
				local calcs = csgo.team[csgo.pot[victim]].count - 1
				
				if calcs == 0 or calcs <= 1 then
					local mess = "The last player " .. victim .. " fell!"
					cs_match.finish_match(csgo.enemy_team(csgo.pot[victim]))
					annouce.winner(csgo.enemy_team(csgo.pot[victim]), mess)
				else
					if cs_match.commenced_match ~= false and died[victim] ~= true then
						cs_kh.add("", player:get_player_name(), "cs_files_suicide.png", "Suicide", csgo.pot[victim])
						
						died[victim] = true
						cs_kill.run_callbacks(victim, nil, nil, csgo.pot[victim])
						
						ccore[victim] = csgo.pot[victim]
						csgo.blank(victim, csgo.pot[victim])
						csgo.spectator(victim)
						csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					end
				end
			end
		elseif reason.type == "drown" then
			if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 then
				local calcs = csgo.team[csgo.pot[victim]].count - 1
				
				if calcs == 0 or calcs <= 1 then
					local mess = "The last player " .. playerr .. " did die by being drowned!.."
					cs_match.finish_match(csgo.enemy_team(var4))
					annouce.winner(csgo.enemy_team(csgo.pot[victim]), mess)
					cs_kh.add("", pname, "cs_files_drown.png", "Drown", csgo.pot[victim])
				else
					if cs_match.commenced_match ~= false and died[victim] ~= true then
						cs_kh.add("", player:get_player_name(), "cs_drown.png", "Drown", csgo.pot[victim])
						
						died[victim] = true
						cs_kill.run_callbacks(victim, nil, nil, csgo.pot[victim])
						
						ccore[victim] = csgo.pot[victim]
						csgo.blank(victim, csgo.pot[victim])
						csgo.spectator(victim)
						csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					end
				end
			end
		elseif reason.type == "node_damage" then
			if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 then
				local calcs = csgo.team[csgo.pot[victim]].count - 1
				
				if calcs == 0 or calcs <= 1 then
					local mess = "The last player " .. victim .. " did die by being sus (from a block)!.."
					cs_match.finish_match(csgo.enemy_team(csgo.pot[victim]))
					annouce.winner(csgo.enemy_team(csgo.pot[victim]), mess)
					local a1 = ItemStack(reason.node)
					local a2 = (a1:get_definition().tiles[1]) or a1:get_definition().textures
					local a3 = a1:get_definition().description
					local a4 = a3:split("\n") --no
					
					cs_kh.add(a4[1], victim, a2, "Suicide", csgo.pot[victim])
				else --cb.registered_on_kill[i](victim, "reason:table", "none", csgo.pot[victim], {node_name = a1:get_name(), reason = "node"})
					if cs_match.commenced_match ~= false and died[victim] ~= true then
						local a1 = ItemStack(reason.node)
						local a2 = (a1:get_definition().tiles[1]) or a1:get_definition().textures
						local a3 = a1:get_definition().description
						local a4 = a3:split("\n") --no
						
						cs_kh.add("", player:get_player_name(), a2, "Suicide", csgo.pot[victim])
						
						died[victim] = true
						cs_kill.run_callbacks(victim, "reason:table", nil, csgo.pot[victim], {node_name = a1:get_name(), reason = "node"})
						
						ccore[victim] = csgo.pot[victim]
						csgo.blank(victim, csgo.pot[victim])
						csgo.spectator(victim)
						csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					end
				end
			end
		end
	end
end)













