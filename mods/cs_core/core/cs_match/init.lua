cs_match = {
	registered_matches = {},
	available_matches = {},
}
phud = {}
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
			player:hud_remove(value)
		end
	end
end)

function cs_match.finished_match(teamare1)
	if cs_match.available_matches == 0 then
		cs_match.commenced_match = false
		ctimer.pause()
		function finishedmatch() return false end
		core.log("action", "Starting new match, {ResetMaps,ResetSettings.}")
		for i = 1, #cb.registered_on_new_matches do
			cb.registered_on_new_matches[i](teamare1)
		end
		cs_map.new_match()
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		csgo.off_movement()
		
		if not minetest.settings:get_bool("cs_map.mapmaking", false) then
			for i, player in pairs(core.get_connected_players()) do
				local pname = player:get_player_name()
				core.chat_send_player(pname, "New Match. Remember there are " .. cs_match.available_matches .. " rounds")
				phud[pname] = player:hud_add({
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
			end
			cs_buying.enable_shopping()
			for i = 1, #cb.registered_on_new_match do
				cb.registered_on_new_match[i]()
			end
			do
				ccore.teams.terrorist.players = {}
				ccore.teams.counter.players = {}
			end
			
			
		end
	
	end
	if (cs_match.available_matches ~= 0)  then
		cs_match.available_matches = cs_match.available_matches - 1
		ctimer.pause()
		cs_match.commenced_match = false
		function finishedmatch() return false end
		
		for i = 1, #cb.registered_on_new_match do
			cb.registered_on_new_match[i]()
		end
		
		cs_core.log("action", "Normal match commenced, available: " .. cs_match.available_matches)
		
		for people in pairs(csgo.team[teamare1].players) do
			bank.player_add_value(people, 100)
		end
		for people in pairs(csgo.team[csgo.enemy_team(teamare1)].players) do
			bank.player_add_value(people, 50)
		end
		
		csgo.off_movement()
		
		if not minetest.settings:get_bool("cs_map.mapmaking", false) then
			for i, player in pairs(core.get_connected_players()) do
				local pname = player:get_player_name()
				core.chat_send_player(pname, "New Match. Remember there are " .. cs_match.available_matches .. " rounds")
				phud[pname] = player:hud_add({
					hud_elem_type = "text",
					--texture = "",
					scale = {x = 1.5, y = 1.5},
					position = {x = 0.800, y = 0.10},
					offset = {x = 30, y = 100},
					size = {x = 1.5},
					alignment = {x = 0, y = -1},
					text = "Be Fast!! shop your arms before time reach!\n You Had 20 Seconds to shop.",
					number = 0xFF9D00,
				})
				
				if (csgo.pot[pname] == "terrorist") then
					if terrorists_spawn() then
						poss = terrorists_spawn()
						player:setpos(poss)
					else
						cs_core.log("error", "By-Core: No position for terrorists found!")
					end
				elseif csgo.pot[pname] == "counter" then
					if counters_spawn() then
						poss = counters_spawn()
						player:setpos(poss)
					else
						cs_core.log("error", "By-Core: No position for counters found!")
					end
				elseif csgo.pot[pname] == "spectator" then
					empty()
				end
			end
			
			cs_buying.enable_shopping()
			for i = 1, #cb.registered_on_new_match do
				cb.registered_on_new_match[i]()
			end
			
			core.after(1, function()
				ccore.teams.terrorist.players = {}
				ccore.teams.counter.players = {}
			end)
			
			if ask_for_bomb() then
				core.after(1.3, function()
					for _, Playerr in pairs(core.get_connected_players()) do
						pname = Playerr:get_player_name()
						if csgo.pot[pname] == "terrorist" and not has_bomb then
							if not ItemFind(Player(Playerr)) then
								InvRef = Playerr:get_inventory()
								InvRef:add_item("main", "bomb")
								core.debug("green", "Giving the bomb to a random player ("..pname..")", "C4 API")
								has_bomb = pname
								return
							end
						end
					end
				end)
			end
			
			
		end
	end

end
function cs_match.start_matches()
		cs_core.log("action", "Starting {Maps, Values, Registers} for the server")

		cs_map.new_match()
		cs_death.register_spawn("all", counters_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
		
		cs_match.register_matches(cs_match.registered_matches) -- Register again all matchs to be default, to change limit, see cs-core/core/core1.lua
		
		ctimer.pause()
		
		if not minetest.settings:get_bool("cs_map.mapmaking", false) then
		if not alreadyVAR then
		--[[[minetest.register_on_joinplayer(function(player)
		csgo.show_menu(player)
		if player and not hud:exists(player, "temp000x15") then
			playeree = player:get_player_name()
			player:get_inventory():set_list("main", {})
			core.chat_send_player(playeree, "You joined on a continued match, matches remaining: " .. cs_match.available_matches)
			minetest.chat_send_player(playeree, "Be Fast!! shop your arms before time reach!\nYou Had ".. minetest.colorize("#FF8282", "20")  .." Seconds to shop.")
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

call.register_on_new_match(function()
--error("test")
core.after(0.1, function()
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
	if has_bomb == playern then
		has_bomb = nil
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













