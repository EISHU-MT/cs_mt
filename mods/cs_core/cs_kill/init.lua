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

for cs_coret, def in pairs(csgo.team) do -- Insert

	if cs_coret ~= "spectator" then
		cs_kill[cs_coret] = {count = 0,}
	end
end
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	pname = hitter:get_player_name()
	victim = player:get_player_name()
	if not pname then
		return
	end
	if (cs_core.ask_can_do_damage(pname) == false) then

		if not hud:exists(pname, "kill") then
			hud:add(pname, "kill", {
				hud_elem_type = "text",
				position = {x = 0.5, y = 0.5},
				offset = {x = 0, y = 45},
				alignment = {x = "center", y = "down"},
				text = S("You can't damage others players!!"),
				color = 0xFFC107,
			})
		else
		if hud:exists(pname, "kill") then
			hud:change(pname, "kill", {text = S("You can't damage others players!!"), color = 0xFFC107})
			end
		end
		
		function temporal()
			if hud:exists(pname, "kill") then
				hud:remove(pname, "kill")
			end
		end
		
		core.after(1.5, temporal)

		return true
	end
	
	if (csgo.pot[pname] == csgo.pot[victim]) then

		if not hud:exists(pname, "kill") then
			hud:add(pname, "kill", {
				hud_elem_type = "text",
				position = {x = 0.5, y = 0.5},
				offset = {x = 0, y = 45},
				alignment = {x = "center", y = "down"},
				text = S("@1 its your teammate! ( ! )", victim),
				color = 0xDC3545,
			})
		else
			if hud:exists(pname, "kill") then
				hud:change(pname, "kill", {text = S("@1 its your teammate! ( ! )", victim), color = 0xDC3545})
			end
		
		end
	
	
		function temporal()
			if hud:exists(pname, "kill") then
				hud:remove(pname, "kill")
			end
		end
		
		
		core.after(1.5, temporal)
		local enable_it = minetest.settings:get_bool("cs_core.enable_friend_shot", false)
		if enable_it ~= true then
			return false
		else
			return true
		end

	end
	-- delete that. this callback will dont be more the kill manager.
	
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
minetest.register_on_player_hpchange(function(player, hp_ch, reason)
	local hp_change = cs_kill.translate_to_real_damage(hp_ch)
	if not hp_change then
		return true
	end
	local pname
	if reason.object then
		pname = reason.object:get_player_name()
	end
	local victim = player:get_player_name()
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
							local image = a1:get_definition().inventory_image
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
							local image = a1:get_definition().inventory_image
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
	
end)













