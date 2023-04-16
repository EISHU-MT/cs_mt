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
	if not hp_change then
		return true
	end
	if reason.type == "punch" and reason.object then
		pname = reason.object:get_player_name()
		victim = player:get_player_name()
		if not victim then
			victim = "nil"
		end
		if player:get_hp() > 0 and player:get_hp() - hp_change <= 0 and reason.object then
		
		
		if csgo.pot[victim] == csgo.pot[pname] then -- They suicide and win, this is not ok >:(
			if csgo.team[csgo.pot[victim]].count - 1 < 0 and csgo.team[csgo.pot[pname]] == 0 then
				--print(csgo.pot[pname])
				if csgo.pot[victim] == "counter" then
					t = "terrorist"
				elseif csgo.pot[victim] == "terrorist" then
					t = "counter"
				end
				local random = clua.aif("Select random", {"The last alive player is: "..victim, "the team "..csgo.pot[pname].." had only 1 player!", "wajaaaa"})
				
				annouce.winner(t, random)
				cs_match.finished_match(csgo.pot[pname])
				for i = 1, #cb.registered_on_kill do
					cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
				end
			elseif csgo.team[csgo.pot[victim]].count - 1 < 1  then
				if csgo.pot[victim] == "counter" then
					t = "terrorist"
				elseif csgo.pot[victim] == "terrorist" then
					t = "counter"
				end
				local random = clua.aif("Select random", {"The last player that suicided is: "..victim, "the team "..t.." did his job", "wajaaa"})
				annouce.winner(t, random)
				cs_match.finished_match(csgo.pot[pname])
				for i = 1, #cb.registered_on_kill do
					cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
				end
			else
				if died[victim] ~= true then 
					
					local a1 = reason.object:get_wielded_item()
					local image = a1:get_definition().inventory_image
					
					cs_kh.add(reason.object:get_player_name(), player:get_player_name(), image, "", csgo.pot[victim])
					
					
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
					
					
					for i = 1, #cb.registered_on_kill do
						cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
					end
					
					
					if finishedmatch() == true then
					core.debug("green", "Putting player "..victim.." into dead players to be respawned again later...", "CS:GO Core")
					ccore.teams[he_team].players[victim] = true
					csgo.send_message(victim .. " will be a spectator. because he died. ", "spectator")
					player:set_armor_groups({immortal = 1})
					--minetest.set_player_privs(victim, {fly=true, fast=true, noclip=true, teleport=true, shout=true}) -- Teleport Is a feature
					end
					core.after(0.2,function()
						csgo.spectator(victim)
					end)
				end
			end
			return
		end
			if csgo.team[csgo.pot[victim]].count - 1 == 0 and csgo.team[csgo.pot[pname]] == 1 then
				--print(csgo.pot[pname])
				local random = clua.aif("Select random", {"The last alive player is: "..victim, "the team "..csgo.pot[pname].." had only 1 player!", "wajaaaa"})
				annouce.winner(csgo.pot[pname], random)
				cs_match.finished_match(csgo.pot[pname])
				for i = 1, #cb.registered_on_kill do
					cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
				end
			elseif csgo.team[csgo.pot[victim]].count - 1 == 0 then
				local random = clua.aif("Select random", {"The last killed player is: "..victim, "the team "..csgo.pot[pname].." did his job", "wajaaa"})
				annouce.winner(csgo.pot[pname], random)
				cs_match.finished_match(csgo.pot[pname])
				for i = 1, #cb.registered_on_kill do
					cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
				end
			else
				if died[victim] ~= true then 
					
					local a1 = reason.object:get_wielded_item()
					local image = a1:get_definition().inventory_image
					
					cs_kh.add(reason.object:get_player_name(), player:get_player_name(), image, "", csgo.pot[victim])
					
					bank.player_add_value(reason.object:get_player_name(), 50) 
					
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
					
					
					for i = 1, #cb.registered_on_kill do
						cb.registered_on_kill[i](victim, pname, csgo.pot[pname], csgo.pot[victim])
					end
					
					
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
			
			--print(pname, csgo.pot[pname])
			
			victim = pname
			
			local var4 = csgo.pot[victim]
			local tokc_TEMP = csgo.team[var4].count - 1
			local tokc = csgo.team[var4].count
			
			local no = csgo.team[var4].count - 1
			
			if csgo.pot[pname] and no == 0 then  -- nEW ForMULA
				mess = "The last player " .. playerr .. " fell!" -- LOL
				cs_match.finished_match(csgo.enemy_team(var4))
				annouce.winner(csgo.enemy_team(var4), mess)
				--cs_kh.add(clua.aif("Select random", {"MrBubble", "bubdle", "bubble", "b0bble"}), victim, "bubble.png", "drown")
			else
				if died[pname] == false or died[pname] == true then
					empty()
				else
					died[pname] = true
				end
				victim = pname or playerr
				died[pname] = true
				he_team = csgo.pot[victim]
				cs_kh.add(pname, pname, "cs_files_bone.png", "(Suicide?)")
				csgo.op[victim] = nil
				csgo.pt[victim] = nil
				csgo.online[victim] = nil
				csgo.pot[victim] = nil
				csgo.team[he_team].players[victim] = nil
				csgo.team[he_team].count = csgo.team[he_team].count - 1
				
				for i = 1, #cb.registered_on_kill do
						cb.registered_on_kill[i](victim, "reason:fall", "none", csgo.pot[victim])
				end
				
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
			local playerr = pname
			
			
			local var4 = csgo.pot[pname]
			
			local no = csgo.team[var4].count - 1
			
			if csgo.pot[pname] and no == 0 then
				mess = "The last player " .. playerr .. " did die by being drowned!.." -- LOL
				cs_match.finished_match(csgo.enemy_team(var4))
				annouce.winner(csgo.enemy_team(var4), mess)
				cs_kh.add(clua.aif("Select random", {"MrBubble", "bubdle", "bubble", "b0bble"}), pname, "bubble.png", "drown")
			else
				if died[pname] == false or died[pname] == true then
					empty()
				else
					died[pname] = true
				end
				victim = pname or playerr
				died[pname] = true
				he_team = csgo.pot[victim]
				cs_kh.add(clua.aif("Select random", {"MrBubble", "bubdle", "bubble", "b0bble"}), pname, "bubble.png", "drown")
				csgo.op[victim] = nil
				csgo.pt[victim] = nil
				csgo.online[victim] = nil
				csgo.pot[victim] = nil
				csgo.team[he_team].players[victim] = nil
				csgo.team[he_team].count = csgo.team[he_team].count - 1
				
				for i = 1, #cb.registered_on_kill do
						cb.registered_on_kill[i](victim, "reason:drown", "none", csgo.pot[victim])
				end
				
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
			
			local no = csgo.team[var4].count - 1
			
			if csgo.pot[pname] and no == 0 then
				mess = "The last player " .. playerr .. " did die by being sus (from a block)!.." -- LOL
				cs_match.finished_match(var4)
				annouce.winner("counter", mess)
				local a1 = ItemStack(reason.node)
				local a2 = (a1:get_definition().tiles[1]) or a1:get_definition().textures
				local a3 = a1:get_definition().description
				local a4 = a3:split("\n") --no
				
				cs_kh.add(a4[1], victim, a2)
			else
				if died[pname] == false or died[pname] == true then
					empty()
				else
					died[pname] = true
				end
				victim = pname or playerr
				died[pname] = true
				he_team = csgo.pot[victim]
				local a1 = ItemStack(reason.node)
				local a2 = a1:get_definition().description
				local a3 = a2:split("\n")
				local a4 = (a1:get_definition().tiles[1]) or a1:get_definition().textures
				cs_kh.add(a3[1], victim, a4)
				csgo.op[victim] = nil
				csgo.pt[victim] = nil
				csgo.online[victim] = nil
				csgo.pot[victim] = nil
				
				for i = 1, #cb.registered_on_kill do
						cb.registered_on_kill[i](victim, "reason:table", "none", csgo.pot[victim], {node_name = a1:get_name(), reason = "node"})
				end
				
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



















