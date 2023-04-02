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


for cs_coret, def in pairs(csgo.team) do -- Insert

	if cs_coret ~= "spectator" then
		cs_kill[cs_coret] = {count = 0,}
	end
end
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	pname = hitter:get_player_name()
	victim = player:get_player_name()
	if (cs_core.ask_can_do_damage(pname) == false) then

		if not hud:exists(pname, "kill") then
			hud:add(pname, "kill", {
				hud_elem_type = "text",
				position = {x = 0.5, y = 0.5},
				offset = {x = 0, y = 45},
				alignment = {x = "center", y = "down"},
				text = "You can't damage others players!!",
				color = 0xFFC107,
			})
		else
			if hud:exists(pname, "kill") then
			hud:change(pname, "kill", {text = "You can't damage others players!!", color = 0xFFC107})
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
				text = victim .. " its your teammate! ( ! )",
				color = 0xDC3545,
			})
		else
			if hud:exists(pname, "kill") then
				hud:change(pname, "kill", {text = victim .. " its your teammate! ( ! )", color = 0xDC3545})
			end
		
		end
	
	
		function temporal()
			if hud:exists(pname, "kill") then
				hud:remove(pname, "kill")
			end
		end
		
		
		core.after(1.5, temporal)
		clua_opts = clua.get_bool("enable_friend_shot", clua.get_table_value("central_csgo"))
		if clua_opts then
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
minetest.register_on_player_hpchange(function(player, hp_ch, reason)
	local hp_change = cs_kill.translate_to_real_damage(hp_ch)
	if reason.type == "punch" and reason.object then
		pname = reason.object:get_player_name()
		victim = player:get_player_name()
		if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 and reason.object then
		
		if (not defuser_guy) then
			defuser_guy = "99hdq66dla--"
		end
		
		if csgo.pot[victim] == "counter" and victim == defuser_guy then -- avoid defusing while dead.
			function defuser_interrupted()
				return true
			end
		end
			if csgo.team[csgo.pot[victim]].count - 1 == 0 then
				--print(csgo.pot[pname])
				local random = clua.aif("Select random", {"The last killed player is: "..victim, "the team "..csgo.pot[pname].." did his job", "wajaaa"})
				annouce.winner(csgo.pot[pname], random)
				cs_match.finished_match(csgo.pot[pname])
				for i = 1, #cb.registered_on_kill do
					cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
				end
			elseif csgo.team[csgo.pot[victim]].count - 1 == 0 and csgo.team[csgo.pot[pname]] == 1 then
				local random = clua.aif("Select random", {"The last alive player is: "..victim, "the team "..csgo.pot[pname].." had only 1 player!", "wajaaaa"})
				annouce.winner(csgo.pot[pname], random)
				cs_match.finished_match(csgo.pot[pname])
				for i = 1, #cb.registered_on_kill do
					cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
				end
			else
				if died[victim] ~= true then 
					
					--core.debug("green", "Player "..victim.." died. register_ondie player is in core2.", "CS:GO Core")
					--return nil
					local he_team = csgo.pot[victim]
					died[victim] = true
					he_team = csgo.pot[victim]
					csgo.op[victim] = nil
					csgo.pt[victim] = nil
					csgo.online[victim] = nil
					csgo.pot[victim] = nil
					csgo.team[he_team].players[victim] = nil
					csgo.team[he_team].count = csgo.team[he_team].count - 1

					if finishedmatch() == true then
					core.debug("green", "Putting player "..victim.." into dead players to be respawned again later...", "CS:GO Core")
					ccore.teams[he_team].players[victim] = true
					csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					player:set_armor_groups({immortal = 1})
					--minetest.set_player_privs(victim, {fly=true, fast=true, noclip=true, teleport=true, shout=true}) -- Teleport Is a feature
					end
					core.after(3,function()
						csgo.spectator(victim)
					end)
				end
			end
			
			
			
		end
	elseif reason.type == "fall" then --
		if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 then
			local pname = player:get_player_name()
			local playerr = player:get_player_name()
			
			
			local var4 = csgo.pot[victim]
			local tokc_TEMP = csgo.team[var4].count - 1
			local tokc = csgo.team[var4].count
			
			
			if csgo.pot[playerr] == "terrorist" and (csgo.team.terrorist.count == tokc_TEMP) then
				mess = "The last player " .. playerr .. " in terrorist team did a suicide today!.." -- LOL
				cs_match.finished_match("counter")
				annouce.winner("counter", mess)
				local a1 = reason.object:get_wielded_item()
				local a2 = a1:get_definition().inventory_image
				cs_kh.add(pname, victim, a2)
			elseif csgo.pot[playerr] == "counter" and (csgo.team.counter.count == tokc_TEMP) then
				mess = "The last player " .. playerr .. " in counters team did a suicide today!.." -- LOL
				cs_match.finished_match("terrorist")
				local a1 = reason.object:get_wielded_item()
				local a2 = a1:get_definition().inventory_image
				cs_kh.add(pname, victim, a2)
				annouce.winner("terrorist", mess)
			else
				died[victim] = true
				he_team = csgo.pot[victim]
				csgo.op[victim] = nil
				csgo.pt[victim] = nil
				csgo.online[victim] = nil
				csgo.pot[victim] = nil
				local a1 = reason.object:get_wielded_item()
				local a2 = a1:get_definition().inventory_image
				cs_kh.add(pname, victim, a2)
				csgo.team[he_team].players[victim] = nil
				csgo.team[he_team].count = csgo.team[he_team].count - 1
				
				if finishedmatch() == true then
					core.debug("green", "Putting player "..victim.." into dead players to be respawned again later...", "CS:GO Core")
					ccore.teams[he_team].players[victim] = true
					csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					player:set_armor_groups({immortal = 1})
					--minetest.set_player_privs(victim, {fly=true, fast=true, noclip=true, teleport=true, shout=true}) -- Teleport Is a feature
				end
				core.after(3,function()
					csgo.spectator(victim)
				end)
			end
		end
	elseif reason.type == "drown" then
		if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 then
			local pname = player:get_player_name()
			local playerr = player:get_player_name()
			
			
			local var4 = csgo.pot[pname]
			local tokc_TEMP = csgo.team[var4].count - 1
			local tokc = csgo.team[var4].count
			
			
			if csgo.pot[playerr] == "terrorist" and (csgo.team.terrorist.count == tokc_TEMP) then
				mess = "The last player " .. playerr .. " did die by being drowned!.." -- LOL
				cs_match.finished_match("counter")
				annouce.winner("counter", mess)
				local a1 = reason.object:get_wielded_item()
				local a2 = a1:get_definition().inventory_image
				cs_kh.add(clua.aif("Select random", {"MrBubble", "bubdle", "bubble", "b0bble"}), victim, "bubble.png", "drown")
			elseif csgo.pot[playerr] == "counter" and (csgo.team.counter.count == tokc_TEMP) then
				mess = "The player " .. playerr .. " is drown!.." -- LOL
				cs_match.finished_match("terrorist")
				local a1 = reason.object:get_wielded_item()
				local a2 = a1:get_definition().inventory_image
				cs_kh.add(clua.aif("Select random", {"MrBubble", "bubdle", "bubble", "b0bble"}), victim, "bubble.png", "drown")
				annouce.winner("terrorist", mess)
			else
				died[victim] = true
				he_team = csgo.pot[victim]
				csgo.op[victim] = nil
				csgo.pt[victim] = nil
				csgo.online[victim] = nil
				csgo.pot[victim] = nil
				local a1 = reason.object:get_wielded_item()
				local a2 = a1:get_definition().inventory_image
				cs_kh.add(clua.aif("Select random", {"MrBubble", "bubdle", "bubble", "b0bble"}), victim, "bubble.png", "drown")
				csgo.team[he_team].players[victim] = nil
				csgo.team[he_team].count = csgo.team[he_team].count - 1
				
				if finishedmatch() == true then
					core.debug("green", "Putting player "..victim.." into dead players to be respawned again later...", "CS:GO Core")
					ccore.teams[he_team].players[victim] = true
					csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					player:set_armor_groups({immortal = 1})
					--minetest.set_player_privs(victim, {fly=true, fast=true, noclip=true, teleport=true, shout=true}) -- Teleport Is a feature
				end
				core.after(3,function()
					csgo.spectator(victim)
				end)
			end
		end
	elseif reason.type == "node_damage" then
		if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 then
			local pname = player:get_player_name()
			local playerr = player:get_player_name()
			
			
			local var4 = csgo.pot[pname]
			local tokc_TEMP = csgo.team[var4].count - 1
			local tokc = csgo.team[var4].count
			
			
			if csgo.pot[playerr] == "terrorist" and (csgo.team.terrorist.count == tokc_TEMP) then
				mess = "The last player " .. playerr .. " did die by being sus (from a block)!.." -- LOL
				cs_match.finished_match("counter")
				annouce.winner("counter", mess)
				local a1 = ItemStack(reason.node)
				local a2 = (a1:get_definition().tiles[1]) or a1:get_definition().textures
				local a3 = a1:get_definition().description
				local a4 = a3:split("\n")
				cs_kh.add(a4[1], victim, a2)
			elseif csgo.pot[playerr] == "counter" and (csgo.team.counter.count == tokc_TEMP) then
				mess = "The player " .. playerr .. " died from a block!.." -- LOL
				cs_match.finished_match("terrorist")
				local a1 = ItemStack(reason.node)
				local a2 = a1:get_definition().description
				local a3 = a2:split("\n")
				local a4 = (a1:get_definition().tiles[1]) or a1:get_definition().textures
				cs_kh.add(a3[1], victim, a4)
				annouce.winner("terrorist", mess)
			else
				died[victim] = true
				he_team = csgo.pot[victim]
				csgo.op[victim] = nil
				csgo.pt[victim] = nil
				csgo.online[victim] = nil
				csgo.pot[victim] = nil
				local a1 = ItemStack(reason.node)
				local a2 = a1:get_definition().description
				local a3 = a2:split("\n")
				local a4 = (a1:get_definition().tiles[1]) or a1:get_definition().textures
				cs_kh.add(a3[1], victim, a4)
				csgo.team[he_team].players[victim] = nil
				csgo.team[he_team].count = csgo.team[he_team].count - 1
				
				if finishedmatch() == true then
					core.debug("green", "Putting player "..victim.." into dead players to be respawned again later...", "CS:GO Core")
					ccore.teams[he_team].players[victim] = true
					csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					player:set_armor_groups({immortal = 1})
					--minetest.set_player_privs(victim, {fly=true, fast=true, noclip=true, teleport=true, shout=true}) -- Teleport Is a feature
				end
				core.after(3,function()
					csgo.spectator(victim)
				end)
			end
		end
	end
	
end)



















