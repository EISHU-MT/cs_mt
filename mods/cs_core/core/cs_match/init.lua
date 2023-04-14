cs_match = {
	registered_matches = {},
	available_matches = {},
}

-- *C* CORE
ccore = { -- New table for a bug fix
	teams = {
	terrorist = {},
	counter = {},
	},
}

for cteam, _ in pairs(ccore.teams) do
	ccore.teams[cteam] = {players = {}, count = 0}
end


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



function cs_match.finished_match(teamare1)
	assert(teamare1, "cs_core error, mods/cs_core/core/cs_match/init.lua Line 44.: No team have been found!")
	if cs_match.available_matches == 0 then
		function finishedmatch() return false end
		for i = 1, #cb.registered_on_end_match do
			cb.registered_on_end_match[i](teamare1)
		end
		core.after(20, function()
			function finishedmatch() return true end
		end)
		cs_core.log("action", "Starting new match, {Maps,ResetSettings.}")
		for i = 1, #cb.registered_on_new_matches do
			cb.registered_on_new_matches[i](teamare1)
		end
		cs_map.new_match()
		cs_death.register_spawn("all", counters_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		csgo.switch("frosen", true)
		
		csgo.off_movement()
		
		
		for _, player in pairs(core.get_connected_players()) do
		if player and not hud:exists(player, "temp000x1") then
			playeree = player:get_player_name()
			core.chat_send_player(playeree, "New Match. Remember there are " .. cs_match.available_matches .. " rounds")
			hud:add(player, "temp000x1", {
			hud_elem_type = "text",
			--texture = "",
			scale = {x = 1.5, y = 1.5},
			position = {x = 0.800, y = 0.10},
			offset = {x = 30, y = 100},
			size = {x = 1.5},
			alignment = {x = 0, y = -1},
			text = "Be Fast!! shop your arms before time reach!\n You Had 20 Seconds to shop.",
			color = 0xFF9D00,
			})
		if hud:exists(player, "timerrrr") then
		hud:remove(player, "timerrrr")
		end
		player:get_inventory():set_list("main", {})
		
		playerr = player:get_player_name()
		if (csgo.online[playerr]) then
		--print("DEBUGN1")
		he_team = csgo.pot[playerr]
		csgo.op[playerr] = nil
		csgo.pt[playerr] = nil
		csgo.online[playerr] = nil
		csgo.pot[playerr] = nil
		hud:remove(playerr)
		csgo.team[he_team].count = csgo.team[he_team].count - 1
		if he_team == "terrorist" then
		main_hud.set_main_terrorist(csgo.team[he_team].count)
		end
		if he_team == "counter" then
		main_hud.set_main_counter(csgo.team[he_team].count)
		end
		csgo.team[he_team].players[playerr] = nil
		end	
		
		
		
		
		
		
		
		
		csgo.show_menu(player)
		
		
		
		
		end
		end
		
		
		
		
		if not clua.get_bool("map_edit", clua.get_table_value("central_csgo")) then
		cs_buying.enable_shopping()
		core.after(1, ctimer.reset)
		core.after(20, cs_buying.disable_shopping)
		core.after(20, remove_hsa)
		function temp999() csgo.switch("frosen", false) end
		core.after(20, temp999)
		core.after(20, csgo.on_movement)
		core.after(20, ctimer.set_timer)
	
		
		
		for i = 1, #cb.registered_on_new_match do
			cb.registered_on_new_match[i]()
		end
		
		core.after(3, function()
		ccore.teams.terrorist.players = {} -- Fixed bug #5
		ccore.teams.counter.players = {} -- Fixed bug #6
		end)
		
		end
		startednewmatch =  true
	
	end
	if (cs_match.available_matches ~= 0)  then
		cs_match.available_matches = cs_match.available_matches - 1
		function finishedmatch() return false end
		for i = 1, #cb.registered_on_end_match do
			cb.registered_on_end_match[i](teamare1)
		end
		core.after(20, function()
		function finishedmatch() return true end
		end)
		cs_core.log("action", "Normal match commenced, available: " .. cs_match.available_matches)
		
		for people in pairs(csgo.team[teamare1].players) do
			bank.player_add_value(people, 100)
		end
		for people in pairs(csgo.team[csgo.enemy_team(teamare1)].players) do
			bank.player_add_value(people, 50)
		end
		
		--cs_map.new_match()
		--cs_death.register_spawn("all", spectators_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		csgo.off_movement()
		
		for i = 1, #cb.registered_on_new_match do
			cb.registered_on_new_match[i]()
		end
		
		for _, player in pairs(core.get_connected_players()) do
		if player and not hud:exists(player, "temp000x1") then
			playeree = player:get_player_name()
			core.chat_send_player(playeree, "New Match. Remember there are " .. cs_match.available_matches .. " rounds")
			hud:add(player, "temp000x1", {
			hud_elem_type = "text",
			--texture = "",
			scale = {x = 1.5, y = 1.5},
			position = {x = 0.800, y = 0.10},
			offset = {x = 30, y = 100},
			size = {x = 1.5},
			alignment = {x = 0, y = -1},
			text = "Be Fast!! shop your arms before time reach!\n You Had 20 Seconds to shop.",
			color = 0xFF9D00,
			})
			--player:get_inventory():set_list("main", {})
			if hud:exists(player, "timerrrr") then
				hud:remove(player, "timerrrr")
			end



			if (csgo.pot[playeree] == "terrorist") then
				
				if terrorists_spawn() then
					poss = terrorists_spawn()
					player:setpos(poss)
				else
					cs_core.log("error", "By-Core: No position for terrorists found!")
				end
			
			elseif csgo.pot[playeree] == "counter" then
				
				
				if counters_spawn() then
					poss = counters_spawn()
					player:setpos(poss)
				else
					cs_core.log("error", "By-Core: No position for counters found!")
				end
			elseif csgo.pot[playeree] == "spectator" then
				
			end
		end
		end
		if not clua.get_bool("map_edit", clua.get_table_value("central_csgo")) then
		cs_buying.enable_shopping()
		core.after(1, ctimer.reset)
		if ask_for_bomb() then
			core.after(1.3, function()
				for _, Player in pairs(core.get_connected_players()) do
					pname = Player:get_player_name()
					if csgo.pot[pname] == "terrorist" then
						if not clua.find_itemstack_from(clua.player(pname), "bomb") then
							InvRef = Player:get_inventory()
							InvRef:add_item("main", "bomb")
							core.debug("green", "Giving the bomb to a random player ("..pname..")", "C4 API")
							return
						end
					end
				end
			end)
		end
		core.after(20, cs_buying.disable_shopping)
		core.after(20, ctimer.set_timer)
		core.after(20, csgo.on_movement)
		core.after(20, remove_hsa)
		core.after(3, function()
		ccore.teams.terrorist.players = {} -- Fixed bug #5
		ccore.teams.counter.players = {} -- Fixed bug #6
		end)
		core.after(20, function()
			function finishedmatch() return true end
		end)
		
		end
	end

end
function cs_match.start_matches()
		cs_core.log("action", "Starting {Maps, Values, Registers} for the server")

		cs_map.new_match()
		cs_death.register_spawn("all", counters_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		
		if not clua.get_bool("map_edit", clua.get_table_value("central_csgo")) then
		if not alreadyVAR then
		minetest.register_on_joinplayer(function(player)
		csgo.show_menu(player)
		if player and not hud:exists(player, "temp000x15") then
			playeree = player:get_player_name()
			player:get_inventory():set_list("main", {})
			core.chat_send_player(playeree, "You joined on a continued match, matches remaining: " .. cs_match.available_matches)
			minetest.chat_send_player(playeree, "Be Fast!! shop your arms before time reach!\nYou Had ".. minetest.colorize("#FF8282", "20")  .." Seconds to shop.")
		cs_buying.enable_shopping(player)
		
		core.after(35, cs_buying.disable_shopping, player)
		
		
		end
		end)
		ctimer.reset()
		core.after(35, ctimer.set_timer)
		function finishedmatch() return false end
		alreadyVAR = true
		end
		end
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		core.after(20, remove_hsa)


end
local function empty() end

call.register_on_new_match(function()
--error("test")
core.after(0.6, function()
	for team in pairs(ccore.teams) do -- New method
			--counters
			--error(team) -- debug
			--error(team)
			if team == "counter" then
				for player in pairs(ccore.teams[team].players) do
					if csgo.team.counter.count == 10 then
						cs_core.log("error", "Can't put player " .. player .. " in counter-terrorist forces... Ignoring this time")
					else
						cs_core.log("action", "Placing again the died player "..player.." into counter-terrorist forces")
						csgo.counter(player, true)
						ccore.teams[team].players[player] = nil
						--minetest.set_player_privs(aplayer, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
					end
				end
			end
			--terrorists
			if team == "terrorist" then
				for player in pairs(ccore.teams[team].players) do
					if csgo.team.counter.count == 10 then
						cs_core.log("error", "Can't put player " .. player .. " in terrorist forces... Ignoring this time")
					else
						cs_core.log("action", "Placing again the died player "..player.." into terrorist forces")
						csgo.terrorist(player, true)
						ccore.teams[team].players[player] = nil
						--minetest.set_player_privs(aplayer, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
					end
				end
			end
		
	end
	for playername in pairs(died) do
		died[playername] = nil
	end

end)
end)






minetest.register_on_leaveplayer(function(player)
local playern = player:get_player_name()
for teamn in pairs(ccore.teams) do
if ccore.teams[teamn].players[playern] == true then
	ccore.teams[teamn].players[playern] = nil
	ccore.teams[teamn].count = ccore.teams[teamn].count - 1
end
end
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













