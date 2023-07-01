cs_match = {
	registered_matches = {},
	available_matches = {},
	hooks = {
		immortal = false,
		immortal_players = {},
		physics = false,
		physics_players = {},
	},
}
phud = {}
-- *C* CORE
ccore = { }


cs_match.default_matches = 15
function cs_match.register_matches(number)
if number then
cs_match.registered_matches = number
cs_match.available_matches = number
else
cs_match.registered_matches = cs_match.default_matches
cs_match.available_matches = cs_match.default_matches
end
end



function remove_hsa()
for _, player in pairs(core.get_connected_players()) do
if player and hud:exists(player, "temp000x1") then
hud:remove(player, "temp000x1")

end
end
end

function cs_match.finish_match(team)
	assert(team, "cs_core error, mods/cs_core/core/cs_match/init.lua Line 42.: No team have been found!")
	for i = 1, #cb.registered_on_end_match do
		cb.registered_on_end_match[i](team)
	end
	cs_match.finished_match(team)
end

call.register_on_timer_commence(function()
	for i, value in pairs(phud) do
		if value and minetest.player_exists(i) then
			local player = core.get_player_by_name(i)
			if player then
				player:hud_remove(value)
			end
		end
	end
end)

function cs_match.finished_match(teamare1)
	if cs_match.available_matches == 0 then
		cs_match.commenced_match = false
		ctimer.pause()
		function finishedmatch() return false end
		core.log("info", "Starting new match, {ResetMaps,ResetSettings.}")
		for i = 1, #cb.registered_on_new_matches do
			cb.registered_on_new_matches[i](teamare1)
		end
		maps.new_map()
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		csgo.off_movement()
		
		if not minetest.settings:get_bool("cs_map.mapmaking", false) then
			for i, player in pairs(core.get_connected_players()) do
				player:set_hp(20)
				local pname = player:get_player_name()
				core.chat_send_player(pname, "New Match. There are " .. cs_match.available_matches .. " matches left")
				phud[pname] = player:hud_add({
					hud_elem_type = "text",
					--texture = "",
					scale = {x = 1.5, y = 1.5},
					position = {x = 0.800, y = 0.10},
					offset = {x = 30, y = 100},
					size = {x = 1.5},
					alignment = {x = 0, y = -1},
					text = "Shop quickly, buy you weapons before the match starts!\n You have 20 Seconds to shop.",
					color = 0xFF9D00,
				})
				csgo.show_menu(player)
			end
				cs_buying.enable_shopping()
			for i = 1, #cb.registered_on_new_match do
				cb.registered_on_new_match[i]()
			end
			do
				ccore = {}
			end
			
			cs_match.hooks.immortal = true
			
		end
	elseif (cs_match.available_matches ~= 0)  then
		cs_match.available_matches = cs_match.available_matches - 1
		ctimer.pause()
		cs_match.commenced_match = false
		function finishedmatch() return false end
		
		for i = 1, #cb.registered_on_new_match do
			cb.registered_on_new_match[i]()
		end
		
		cs_match.hooks.immortal = true
		
		core.log("info", "Normal match started, available: " .. cs_match.available_matches)
		
		for people in pairs(csgo.team[teamare1].players) do
			bank.player_add_value(people, 100)
		end
		for people in pairs(csgo.team[csgo.enemy_team(teamare1)].players) do
			bank.player_add_value(people, 50)
		end
		
		csgo.off_movement()
		
		core.after(1, function()
			if not minetest.settings:get_bool("cs_map.mapmaking", false) then
				for i, player in pairs(core.get_connected_players()) do
					player:set_hp(20)
					local pname = player:get_player_name()
					core.chat_send_player(pname, "New Match. There are " .. cs_match.available_matches .. " matches left")
					phud[pname] = player:hud_add({
						hud_elem_type = "text",
						--texture = "",
						scale = {x = 1.5, y = 1.5},
						position = {x = 0.800, y = 0.10},
						offset = {x = 30, y = 100},
						size = {x = 1.5},
						alignment = {x = 0, y = -1},
						text = "Shop quickly, buy your weapons before the match starts!\n You have 20 Seconds to shop.",
						number = 0xFF9D00,
					})
					if ccore[pname] then
						csgo[ccore[pname]](pname)
					end
					
					local armor_groups = player:get_armor_groups()
					player:set_armor_groups({
						fleshy = armor_groups.fleshy or 120,
						immortal = 0,
					})
					cs_match.hooks.immortal_players[player:get_player_name()] = false
					
					if (csgo.pot[pname] == "terrorist") then
						if terrorists_spawn() then
							poss = terrorists_spawn()
							player:set_pos(poss)
						else
							core.log("error", "By-Core: No position for terrorists found!")
						end
					elseif csgo.pot[pname] == "counter" then
						if counters_spawn() then
							poss = counters_spawn()
							player:set_pos(poss)
						else
							core.log("error", "By-Core: No position for counters found!")
						end
					elseif csgo.pot[pname] == "spectator" then
						empty()
					end
					
					if died_players[player:get_player_name()] then
						died_players[player:get_player_name()]:remove() -- Remove the body
					end
				end
				
				cs_buying.enable_shopping()
				for i = 1, #cb.registered_on_new_match do
					cb.registered_on_new_match[i]()
				end
				
				--[[for player, team in pairs(ccore) do
					if player and team and csgo.team[team] and csgo.team[team].count ~= csgo.usrTlimit then
						if minetest.settings:get_bool("cs_core.enable_env_debug", false) then
							core.log("error", "Can't put player " .. player .. " in "..team.." team, its full!")
						end
						csgo.spectator(player, "Joined spectator team! because: Cannot join "..team)
					elseif player and team and csgo.team[team] then
						if minetest.settings:get_bool("cs_core.enable_env_debug", false) then
							core.log("action", "Respawning killed player "..player.." into terrorist forces")
						end
						--error(player .. team)
						csgo[team](player)
						ccore[player] = nil
					end
					died[player] = nil
				end--]]
				
				core.after(3, function()
					ccore = {}
					died = {} -- reset
				end)
				
				if ask_for_bomb() then
					core.after(1.3, function()
						for _, Playerr in pairs(core.get_connected_players()) do
							pname = Playerr:get_player_name()
							if csgo.pot[pname] == "terrorist" and not has_bomb then
								if not ItemFind(Player(Playerr)) then
									InvRef = Playerr:get_inventory()
									InvRef:add_item("main", "bomb")
									core.log("info", "Giving the bomb to a random player ("..pname..")")
									has_bomb = pname
									return
								end
							end
						end
					end)
				end
				
				
			end
			
		end)
	end

end
function cs_match.start_matches()
		core.log("info", "Starting {Maps, Values, Registers} for the server")

		maps.new_map()
		--cs_death.register_spawn("all", counters_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		csgo.off_movement()
		
		ctimer.pause()
		
		cs_match.hooks.immortal = true
		
		if not minetest.settings:get_bool("cs_map.mapmaking", false) then
		if not alreadyVAR then
		--[[[minetest.register_on_joinplayer(function(player)
		csgo.show_menu(player)
		if player and not hud:exists(player, "temp000x15") then
			playeree = player:get_player_name()
			player:get_inventory():set_list("main", {})
			core.chat_send_player(playeree, "You joined in the middle of a match, matches remaining: " .. cs_match.available_matches)
			minetest.chat_send_player(playeree, "Shop quickly, buy your weapons before the match starts\nYou have ".. minetest.colorize("#FF8282", "20")  .." Seconds to shop.")
		cs_buying.enable_shopping(player)
		
		core.after(35, cs_buying.disable_shopping, player)
		
		
		end
		end)--]]
		--ctimer.reset()
		--ctimer.reset()
		function finishedmatch() return false end
		alreadyVAR = true
		end
		end
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		core.after(20, remove_hsa)


end
local function empty() end



call.register_on_timer_commence(function()
	for name, bool in pairs(cs_match.hooks.immortal_players) do
		for _, pname in pairs(core.get_connected_names()) do
			if name == pname and csgo.pot[name] and csgo.pot[name] ~= "spectator" then
				local player = Player(name)
				if player and player ~= "" then
					local armor_groups = player:get_armor_groups()
					player:set_armor_groups({
						fleshy = armor_groups.fleshy or 120,
						immortal = 0,
					})
				end
			end
		end
	end
end)


minetest.register_on_leaveplayer(function(player)
	local playern = player:get_player_name()
	ccore[playern] = nil
	died[playern] = nil
	if has_bomb == playern then
		has_bomb = nil
	end
	phud[playern] = nil
end)







minetest.register_chatcommand("cs_match_start", {
    privs = {core = true},
    func = function(name, param)
    	local number = math.random(2)
		if number == 1 then
			team = "terrorist"
		end
		if number == 2 then
			team = "counter"
		end
		if team then
    	cs_match.finished_match(team)
		elseif param then
			cs_match.finished_match(param)
		end
        
    end,
})













