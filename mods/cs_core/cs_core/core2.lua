-- Only API and Menu
local storage = minetest.get_mod_storage("core")
cs_core.main_seconds = 10
csgo = {}
csgo = {
	team = { -- All modes need a variable "inf" registered with a value "true" for valid team.
		counter = {colour = "#0081FF"}, -- Counter Terrorist Forces
		terrorist = {colour = "#FF8500"}, -- Terrorist Forces
		spectator = {}, -- When a player die. Turns into a spectator
	},
	ctl = {}, -- Current team list
	op = {}, -- Online Players, DEF_L1:::=If a player are in those three teams {c,t,s}
	pt = {}, -- Player team
	pot = {}, -- Name of team in a player ENV
	pot2 = {},
	teams = {}, -- DEF:::={inf=nil}
	spect = {}, -- Spectators from menu
	teamed = {}, -- if player enter in a team
	online = {},

}
phooks = {}
csgo.usrTlimit = 20
cs = {}
function cs.s_t(name)
player_api.set_textures(name, "red.png")
end
function cs.s_c(name)
player_api.set_textures(name, "blue.png")
end

do
	local strs = storage:get_string("players")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = true
				}
		local sr = core.serialize(newtable)
		storage:set_string("players", sr)
	end
end

function csgo.get_team_colour(team)
	if not team or team == "" or team == " " then
		return "#FFFFFF"
	end
	return csgo.team[team].colour
end


for team, def in pairs(csgo.team) do -- Insert
	if team == "terrorist" then
		co = "#FF8500"
		coc = 0xFF8500
		fco = "#FF0000"
	elseif team == "counter" then
		co = "#0081FF"
		coc = 0x0081FF
		fco = "#0000FF"
	elseif team == "spectator" then
		co = "#008C0B"
		coc = 0x008C0B
		fco = "#00FF00"
	end
	csgo.team[team] = {count = 0, players = {}, inf = true, colour = co, colour_code = coc, form_color = fco}
	table.insert(csgo.ctl, team)
end

function csgo.enemy_team(team)
	if team then
		if team == "counter" then
			return "terrorist"
		elseif team == "terrorist" then
			return "counter"
		elseif team == "spectator" then
			return "spectator"
		end
		return false, "nothing"
	end
end

function csgo.random_player(team)
	if not team then
		return nil
	end
	return csgo.team[team].players[math.random(#csgo.team[team].players)]
end

function csgo.uncompress_players()
	local strs = storage:get_string("players")
	if strs ~= "" or strs ~= " " or strs ~= nil then
		local data = core.deserialize(strs)
		return data
	end
end

function csgo.compress_player(player) -- Name, not userdata
	local strs = storage:get_string("players")
	if strs ~= "" or strs ~= " " or strs ~= nil then
		local data = core.deserialize(strs)
		data[player] = true
		local sr = core.serialize(data)
		storage:set_string("players", sr)
	end
end

function csgo.delete_compressed_player(player) -- Name, not userdata
	local strs = storage:get_string("players")
	if strs ~= "" or strs ~= " " or strs ~= nil then
		local data = core.deserialize(strs)
		data[player] = nil
		local sr = core.serialize(data)
		storage:set_string("players", sr)
	end
end

function csgo.check_compressed_player(player)
	local strs = storage:get_string("players")
	if strs ~= "" or strs ~= " " or strs ~= nil then
		local data = core.deserialize(strs)
		return data[player]
	end
end

function csgo.check_team(player)
	return csgo.pot[player] or "spectator"
end

function csgo.send_message(message, team, player) -- Send a message to every player in the specified team.
	if (csgo.team[team].inf == true) then -- Verify team before continue.
		for aplayer, def in pairs(csgo.team[team].players) do
			if (player) then
				core.chat_send_player(aplayer, player .. message)
			else
				core.chat_send_player(aplayer, message)
			end
		end
	end
end
function csgo.blank(player, team)
	csgo.op[player] = nil
	csgo.pt[player] = nil
	csgo.online[player] = nil
	csgo.spect[player] = nil
	csgo.pot2[player] = nil
	if team or csgo.check_team(player) then
		csgo.team[team or csgo.check_team(player)].count = csgo.team[team or csgo.check_team(player)].count - 1
		csgo.team[team or csgo.check_team(player)].players[player] = nil
	end
	csgo.pot[player] = nil
end
function csgo.spectator(player, reason)
	local team = "spectator"
	csgo.op[player] = nil
	csgo.pt[player] = nil
	csgo.online[player] = true
	csgo.spect[player] = true
	csgo.pot2[player] = "spectator"
	csgo.team[team].players[player] = true
	csgo.team[team].count = csgo.team[team].count + 1
	AddPrivs(player, {fly=true, noclip=true, shout=true, fast=true, interact=false, teleport=true})
	if csgo.check_team(player) then
		csgo.team[csgo.check_team(player)].count = csgo.team[csgo.check_team(player)].count - 1
		csgo.team[csgo.check_team(player)].players[player] = nil
	end
	csgo.pot[player] = team
	
	local properties = Player(player):get_properties()
	
	Player(player):hud_set_flags({
		wielditem = false,
	})
	
	properties.pointable = false
	properties.show_on_minimap = false
	properties.is_visible = false
	properties.makes_footstep_sound = false
	Player(player):set_properties(properties)
	
	local pobj = Player(player)
	pobj:set_armor_groups({immortal = 1})
	Inv(player):set_list("main", {})
	core.after(1, function(playe) playe:set_list("main", {}) end, Inv(player))
	player_core.upgrade_to_mode(player, "empty.b3d")
	cs_core.can_do_damage(player, "no")

	
	if (reason) then
		csgo.send_message(player .. " " .. reason, team) -- No building auto-reasons by machine!
	end
	if spectators_spawn() then
		Player(player):set_pos(spectators_spawn())
	else
		core.log("error", "By-Core: No position for spectators found!")
	end
end
--print(csgo.usrTlimit)
function csgo.terrorist(player, force)
	if not player then
		return
	end
	if csgo.team.terrorist.count == csgo.usrTlimit or force then
		csgo.spectator(player, "has joined spectators, no space for terrorist team")
		minetest.log("warning", "Unavailable space for team counters. Ignoring for this time....")
	else
		if csgo.check_team(player) then
			csgo.team[csgo.check_team(player)].count = csgo.team[csgo.check_team(player)].count - 1
			csgo.team[csgo.check_team(player)].players[player] = nil
		end
		csgo.spect[player] = nil
		csgo.op[player] = true
		csgo.pt[player] = true
		csgo.pot2[player] = "terrorist"
		csgo.online[player] = true
		csgo.pot[player] = "terrorist"
		csgo.team.terrorist.count = csgo.team.terrorist.count + 1
		csgo.team.terrorist.players[player] = true
		if not FindItem(Player(player), "rangedweapons:glock17") then
			Inv(player):add_item("main", "rangedweapons:glock17")
			Inv(player):add_item("main", "rangedweapons:9mm 200")
		end
		for i = 1, #cb.registered_on_join_team do
			cb.registered_on_join_team[i](player, "terrorist")
		end
		
		Player(player):hud_set_flags({
			wielditem = true,
		})
		
		local properties = Player(player):get_properties()
		properties.pointable = true
		properties.show_on_minimap = false
		properties.is_visible = true
		properties.makes_footstep_sound = true
		Player(player):set_properties(properties)
		
		AddPrivs(player, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
		Player(player):set_armor_groups({fleshy = 120})
		
		local t = {"terrorist.b3d", "terrorist2.b3d"}
		local n = #t
		player_core.upgrade_to_mode(player, t[math.random(n)])
		
		cs_core.can_do_damage(player, "yes")
		csgo.send_message(player .. " Joins the Terrorist forces", "terrorist")
		if terrorists_spawn() then
			Player(player):set_pos(RandomPos(terrorists_spawn(), 1))
		else
			minetest.log("error", "By-Core: No position for terrorists found!")
		end
	end
end

function csgo.counter(player, force)
	if not player then
		return
	end
	if csgo.team.counter.count == csgo.usrTlimit or force then
		csgo.spectator(player, "has joined spectators, no space for counter team")
		minetest.log("warning", "Unavailable space for team counters. Ignoring for this time....")
	else
		if csgo.check_team(player) then
			csgo.team[csgo.check_team(player)].count = csgo.team[csgo.check_team(player)].count - 1
			csgo.team[csgo.check_team(player)].players[player] = nil
		end
		csgo.spect[player] = nil
		csgo.op[player] = true
		csgo.pt[player] = true
		csgo.pot2[player] = "counter"
		csgo.online[player] = true
		csgo.pot[player] = "counter"
		csgo.team.counter.count = csgo.team.counter.count + 1
		csgo.team.counter.players[player] = true
		if not FindItem(Player(player), "rangedweapons:m1991") then
			Inv(player):add_item("main", "rangedweapons:m1991")
        		Inv(player):add_item("main", "rangedweapons:45acp 200")
		end
		for i = 1, #cb.registered_on_join_team do
			cb.registered_on_join_team[i](player, "counter")
		end
		
		local properties = Player(player):get_properties()
		
		Player(player):hud_set_flags({
			wielditem = true,
		})
		
		properties.pointable = true
		properties.show_on_minimap = false
		properties.is_visible = true
		properties.makes_footstep_sound = true
		Player(player):set_properties(properties)
		
		AddPrivs(player, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
		Player(player):set_armor_groups({fleshy = 120})
		player_core.upgrade_to_mode(player, "counter.b3d")
		cs_core.can_do_damage(player, "yes")
		csgo.send_message(player .. " Joins the Terrorist forces", "counter")
		if counters_spawn() then
			Player(player):set_pos(RandomPos(counters_spawn(), 1))
		else
			minetest.log("error", "By-Core: No position for counters found!")
		end
	end
end



function preparenow(messa)
if (messa) then
cs_core.message = messa
else
cs_core.message = "Select Fast!! in 10 seconds this menu closes and theres no back!"
end
end
function csgo.main(name)
    local formspec = {
        "formspec_version[6]" ..
	"size[17,11]" ..
	"box[-0.1,0;17.5,1.1;#ff4400]" ..
	"label[0.3,0.5;Counter Strike Like]" ..
	"label[12,0.5;Version: "..version.."]" ..
	"label[4.3,10.4; ]" ..
	"label[0.1,8.9; Theres a limit of players in every team Terrorists Limit: "..tostring(csgo.usrTlimit).."\n Counters Limit: "..tostring(csgo.usrTlimit).."]" ..
	"button[7,1.1;3,7.5;spect;Spectator]" ..
	"image_button[0,1.1;7,7.5;core_counter.png;counterr;Counter Terrorists\nCount: ".. minetest.formspec_escape(csgo.team.counter.count) ..";false;true;core_counterstart.png]" ..
	"image_button[10,1.1;7,7.5;core_terrorist.png;terrorist;Terrorists Forces\nCount: ".. minetest.formspec_escape(csgo.team.terrorist.count) ..";false;true;core_terroriststart.png]" ..
	"image_button_exit[12.1,9.3;3.7,1;invisible.png;autoselect;AutoSelect]"
    }
    
    

    return table.concat(formspec, "")
end

function empty() end

call.register_on_end_match(function()
	for _, player in pairs(minetest.get_connected_players()) do
		if player then
			player:set_hp(20)
		end
	end
end)


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "core:main" then
        return
    end
		
	if fields.terrorist then
        local pname = player:get_player_name()
        if not csgo.team.terrorist.count == csgo.usrTlimit then
        var = "no teams had to join. Because teams limit reached"
        csgo.spectator(pname, var)
        else
        csgo.terrorist(pname) 
        end
        core.close_formspec(pname, "core:main")
    	
    end
    
    if fields.counterr then
        local pname = player:get_player_name()
        if not csgo.team.counter.count == csgo.usrTlimit then
        var = "no teams had to join. Because teams limit reached"
        csgo.spectator(pname, var)
        else
        
        csgo.counter(pname)
        end
        core.close_formspec(pname, "core:main")
    end
    
    
    if fields.spect then
        local pname = player:get_player_name()
        local var = "will be a spectator, reason: no died but required from main menu."
        csgo.spectator(pname, var)
        core.close_formspec(pname, "core:main")
    end
    
    if fields.autoselect then
        local pname = player:get_player_name()
        terminate(math.random(1, 2), pname)
        core.close_formspec(pname, "core:main")
    end
end)



function temp(name)
    minetest.show_formspec(name, "core:main", csgo.main(name))
end
minetest.register_chatcommand("t", {
    func = function(name, param)
    	local team = csgo.pot[name]
    	if team == "counter" then
        csgo.send_message(minetest.colorize("#3491FF", " ** " .. param .. " **"), team, "["..name.." at "..maps.get_name_of_pos(Player(name):get_pos()).."]")
        elseif team == "terrorist" then
        csgo.send_message(minetest.colorize("#FFA900", " ** " .. param .. " **"), team, "["..name.." at "..maps.get_name_of_pos(Player(name):get_pos()).."]")
        elseif team == "spectator" then
        csgo.send_message("["..name.."]"..minetest.colorize("#00C200", " ** " .. param .. " **"), team)
        end
        
    end,
})

minetest.register_chatcommand("lteams", {
    func = function(name, param)
		--csgo.team.terrorist.players
		--
		ch1 = {}
		for person in pairs(csgo.team.counter.players) do

			table.insert(ch1, person)
		end
		ch2 = {}
		for person in pairs(csgo.team.terrorist.players) do
			table.insert(ch2, person)
		end
    	core.chat_send_player(name, "Terrorists team: Count: "..csgo.team.terrorist.count..", Players: "..table.concat(ch2, ", "))
        core.chat_send_player(name, "Counters team: Count: "..csgo.team.counter.count..", Players: "..table.concat(ch1, ", "))
        local val23 = csgo.team.counter.count + csgo.team.terrorist.count
        core.chat_send_player(name, "Total: Terrorists and Counters count: "..val23)
    end,
})
--[[
minetest.register_chatcommand("gameee", {
    func = function(name)



    	temp(name)

        
    end,
})
]]

function terminate(var, pname)
	if pname and (not csgo.pot[pname]) then
		if (csgo.team.terrorist.count > csgo.team.counter.count) then
			csgo.counter(pname)
		end
		if (csgo.team.counter.count > csgo.team.terrorist.count) then
			csgo.terrorist(pname)
		end
		if (csgo.team.counter.count == csgo.usrTlimit and csgo.team.terrorist.count == csgo.usrTlimit) then
			csgo.spectator(pname)
		end
		if (csgo.team.counter.count == 0 and csgo.team.terrorist.count == 0 or csgo.team.terrorist.count == csgo.team.counter.count) then
			if var == 1 then
			csgo.counter(pname)
			end
			if var == 2 then
			csgo.terrorist(pname)
			end
		end
	end
end








function doit(name)
	if name then
		local term_var = math.random(1, 2)
		terminate(term_var, name)
		core.close_formspec(name, "core:main")
	end
end

defuser_huds = {}

minetest.register_on_joinplayer(function(playerrrr)
	local player = playerrrr
	
	if (not minetest.settings:get_bool("cs_map.mapmaking", false)) and csgo.check_compressed_player(playerrrr:get_player_name()) then
		player:set_hp(20)
		
		--local n = math.random(800, 20000)
		--player:set_pos({x=0, y=n, z=0})
		
		phooks[playerrrr:get_player_name()] = 10
		--print(phooks[playerrrr:get_player_name()])
		
		player:set_armor_groups({immortal=1})
		
		if csgo.team.terrorist.count ~= csgo.usrTlimit and csgo.team.counter.count ~= csgo.usrTlimit then
			if not history[Name(player)] then -- Check if player is cheating or not
				core.show_formspec(player:get_player_name(), "core:main", csgo.main())
			else
				core.chat_send_player(Name(player), "-!- You Joined back in your team.")
				local team = history[Name(player)]
				csgo[team](Name(player))
			end
		elseif csgo.team.terrorist.count == csgo.usrTlimit then
			csgo.counter(player:get_player_name())
		elseif csgo.team.counter.count == csgo.usrTlimit then
			csgo.terrorist(player:get_player_name())
		else
			csgo.spectator(player:get_player_name())
			core.chat_send_player(player:get_player_name(), core.colorize("#FF3100", "We're sorry but the teams limit got reached... "))
		end
		
		defuser_huds[playerrrr:get_player_name()] = playerrrr:hud_add({
			hud_elem_type = "text",
			name = "defuser_timer",
			scale = {x = 1.5, y = 1.5},
			position = {x = 0.5, y = 0.5},
			offset = {x = 0, y = 20},
			--size = {x = 2},
			alignment = {x = "center", y = "down"},
			--alignment = {x = 0, y = -1},
			text = " ",
			number = 0xCECECE,
		})
		player:set_physics_override({
			sneak_glitch = true,
		})
		player:hud_set_flags({minimap=false, basic_debug=false})
		--cs_buying.enable_shopping(player)
		
		
	end

end)

do
	time_hooks = 0
	time_hooks2 = 0
end

core.register_globalstep(function(dtime)
	time_hooks = time_hooks + dtime
	time_hooks2 = time_hooks2 + dtime
	local players = core.get_connected_players()
	if time_hooks >= 1 then
		time_hooks = 0
		for i, val, NAME in pairs(phooks) do
			--print(i, val)
			for _, p in pairs(players) do
			--	print("bbbbb")
				if p:get_player_name() == i then
				--	print("nashe")
				--error(val)
					if phooks[i] then
						--print("a")
						if csgo.pot[p:get_player_name()] then
							phooks[i] = nil
							return
						end
						local value = phooks[i]
						phooks[i] = value - 1
						if phooks[i] < 4 or phooks[i] == 4 then
							core.chat_send_player(i, core.colorize("#F66060", "Selecting autoselect in "..tostring(phooks[i])))
						end
						--print(phooks[i])
						if phooks[i] < 0 or phooks[i] == 0  then
							doit(i)
							--print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
							phooks[i] = nil
						end
					end
				end
			end
		end
	end
	if time_hooks2 >= 2 and (not minetest.settings:get_bool("cs_map.mapmaking", false)) then
		for _, player in pairs(core.get_connected_players()) do
			local name = Name(player)
			if csgo.pot[name] ~= nil or csgo.online[name] ~= true then
				if type(phooks[name]) ~= "number" then
					phooks[player:get_player_name()] = 10
				end
			end
		end
		time_hooks2 = 0
	end
end)



function csgo.show_menu(playeri)
	if (not minetest.settings:get_bool("cs_map.mapmaking", false)) then
		if not playeri then
			return
		end
		
		playeri:set_hp(20)
		
		playeri:set_armor_groups({immortal=1})
		
		if csgo.team.terrorist.count ~= csgo.usrTlimit and csgo.team.counter.count ~= csgo.usrTlimit then
			core.show_formspec(playeri:get_player_name(), "core:main", csgo.main())
		elseif csgo.team.terrorist.count == csgo.usrTlimit then
			csgo.counter(playeri:get_player_name())
		elseif csgo.team.counter.count == csgo.usrTlimit then
			csgo.terrorist(playeri:get_player_name())
		else
			csgo.spectator(playeri:get_player_name())
			core.chat_send_player(playeri:get_player_name(), core.colorize("#FF3100", "We're sorry but the teams limit got reached... "))
		end
		
		defuser_huds[playeri:get_player_name()] = playeri:hud_add({
			hud_elem_type = "text",
			name = "defuser_timer",
			scale = {x = 1.5, y = 1.5},
			position = {x = 0.5, y = 0.5},
			offset = {x = 0, y = 20},
			--size = {x = 2},
			alignment = {x = "center", y = "down"},
			--alignment = {x = 0, y = -1},
			text = " ",
			number = 0xCECECE,
		}) -- hehe, here must be an error but its solved a long time ago in top of this file
		playeri:set_physics_override({
			sneak_glitch = true,
		})
		playeri:hud_set_flags({minimap=false, basic_debug=false})
		phooks[playeri:get_player_name()] = 10
	end
end

core.send_leave_message = function(pname, timedout)
	if timedout then
		msg = "### "..core.colorize(csgo.get_team_colour(csgo.pot[pname]) or "#FFFFFF", pname).." left the game. (Timed Out)"
	else
		msg = "### "..core.colorize(csgo.get_team_colour(csgo.pot[pname]) or "#FFFFFF", pname).." left the game."
	end
	core.chat_send_all(msg or "*** "..pname.." left the game....")
end

core.send_join_message = function(pname)
	msg = "### "..core.colorize("#D2D2D2", pname).." joins the game!"
	core.chat_send_all(msg or "*** "..pname.." left the game....")
end


--[[
minetest.register_on_dieplayer(function(player, reason)
--print(dump(reason))
	if reason.type == "fall" and csgo.pot[player:get_player_name()] then

		local pname = player:get_player_name()
		
		local var4 = csgo.pot[pname]
		
		local tokc_TEMP = csgo.team[var4].count - 1
		local tokc = csgo.team[var4].count
		
		local playerr = player:get_player_name()
		if csgo.pot[playerr] == "terrorist" and (csgo.team.terrorist.count == tokc_TEMP) then
		mess = "The last player " .. playerr .. " in terrorist team did a suicide today!.." -- LOL
		cs_match.finished_match("counter")
		annouce.winner("counter", mess)
		end
		if csgo.pot[playerr] == "counter" and (csgo.team.counter.count == tokc_TEMP) then
		mess = "The last player " .. playerr .. " in counters team did a suicide today!.." -- LOL
		cs_match.finished_match("terrorist")
		annouce.winner("terrorist", mess)
		
		end
		return
	end
	
	--print(pname) -- DEBUG
	
	
	
	
	
	local pname = player:get_player_name()
--core.after(2, function()
	if (csgo.online[pname]) then
		he_team = csgo.pot[pname]
		csgo.op[pname] = nil
		csgo.pt[pname] = nil
		csgo.online[pname] = nil
		csgo.pot[pname] = nil
		died[pname] = true

		if finishedmatch() == false then
		core.debug("green", "Putting player "..pname.." into dead players to be respawned again later...", "CS:GO Core")
		ccore.teams[he_team].players[pname] = true
		
		csgo.send_message(pname .. " will be a spectator. because he died. ", "spectator")
		player:set_armor_groups({immortal = 1})
		--minetest.set_player_privs(pname, {fly=true, fast=true, noclip=true, teleport=true, shout=true}) -- Teleport Is a feature
		end

		csgo.team[he_team].count = csgo.team[he_team].count - 1
		csgo.team[he_team].players[pname] = nil
		csgo.spectator(pname)
	end
--end)

	--print(reason)
end)
--]]
minetest.register_on_respawnplayer(function()
	return true
end)
