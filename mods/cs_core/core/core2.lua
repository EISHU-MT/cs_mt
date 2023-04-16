-- Only API and Menu

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
	teams = {}, -- DEF:::={inf=nil}
	spect = {}, -- Spectators from menu
	
	online = {},

}
csgo.usrTlimit = 20
cs = {}
function cs.s_t(name)
player_api.set_textures(name, "red.png")
end
function cs.s_c(name)
player_api.set_textures(name, "blue.png")
end


for team, def in pairs(csgo.team) do -- Insert
	if team == "terrorist" then
		co = "#FF8500"
		coc = 0xFF8500
	elseif team == "counter" then
		co = "#0081FF"
		coc = 0x0081FF
	end
	csgo.team[team] = {count = 0, players = {}, inf = true, colour = co, colour_code = coc}
	table.insert(csgo.ctl, team)
end

function csgo.enemy_team(team)
	if team then
		if team == "counter" then
			return "terrorist"
		elseif team == "terrorist" then
			return "counter"
		elseif team == "spectator" then
						error("Cant get an enemy team for spectator!")
			return false
		end
		return false, "nothing"
	end
end

function csgo.send_message(message, team, player) -- Send a message to every player in the specified team.
	if (csgo.team[team].inf == true) then -- Verify team before continue.
		for aplayer, def in pairs(csgo.team[team].players) do
			if (player) then
				core.chat_send_player(aplayer, "[" .. player .. "] " .. message)
			else
				core.chat_send_player(aplayer, message)
			end
		end
	end
end
function csgo.spectator(player, reason) -- Called when he died or directly turns into a spectator from menu
	local ttt = "spectator"
	playerr = minetest.get_player_by_name(player)
	csgo.op[player] = nil -- Disable him
	csgo.pt[player] = nil -- Disable him
	csgo.online[player] = true
	csgo.spect[player] = true
	csgo.team[ttt].players[player] = true
	minetest.set_player_privs(player, {fly=true, fast=true, noclip=true, teleport=true, interact=nil, shout=true}) -- shout is nil because the spectator will tell to the players where the enemy stands.
	if csgo.pot[player] == "terrorist" then -- BUG FIX #1
		local tea = "terrorist"
		csgo.team[tea].count = csgo.team[tea].count - 1
		main_hud.set_main_terrorist(csgo.team[tea].count)
		csgo.team[tea].players[player] = nil
	elseif csgo.pot[player] == "counter" then
		local tea = "counter"
		csgo.team[tea].count = csgo.team[tea].count - 1
		main_hud.set_main_counter(csgo.team[tea].count)
		csgo.team[tea].players[player] = nil
	end
	if playerr then
	playerr:set_armor_groups({immortal = 1, })
	--playerr:set_player_privs({fly = true, shout = true, fast = true, noclip = true, interact = nil})
	minetest.set_player_privs(player, {fly = true, shout = true, fast = true, noclip = true, interact = nil})
	local invvv = playerr:get_inventory()
	--invvv:set_list("main", {}) -- Dropondie now is the eraser...
	end
	
	player_core.upgrade_to_mode(player, "empty.b3d")

	csgo.pot[player] = ttt

	csgo.team[ttt].count = csgo.team[ttt].count + 1
	cs_core.can_do_damage(player, "no") -- Cant put damage to playing players
	csgo.team[ttt].players[player] = true -- Put that plater in spectator-mode team. DEF:::={inf="L48", search="spectator"}
	if (reason) then
	csgo.send_message(player .. " " .. reason, ttt) -- No building auto-reasons by machine!
	end
	if cs_death.team.spectator.pos then
		poss = cs_death.team.spectator.pos
		if playerr then
		playerr:set_pos(poss)
		end
		else
		core.log("error", "By-Core: No position for spectators found!")
	
	end
end
--print(csgo.usrTlimit)
function csgo.terrorist(player, force)
local ttt = "terrorist"
	if ccc(player) then
		empty()
	else
		return
	end
if player then
	if (csgo.op[player] ~= true ) then
		if csgo.spect[player] == true then
			--csgo.spectator(player, "joined spectators, reason: Teams Limit has reached or other things....")
			--error('no')
			empty()
			if csgo.team[ttt].count == 20 then
			empty() -- Ignore if teams limit is reached.
			minetest.log("warning", "Unavailable space for team counters. Ignoring for this time....")
			else
			if force then
			playerr = minetest.get_player_by_name(player)
			
			csgo.spect[player] = nil
			csgo.op[player] = true
			csgo.pt[player] = true
			csgo.online[player] = true
			csgo.pot[player] = "terrorist"
			csgo.team[ttt].count = csgo.team[ttt].count + 1

			for i = 1, #cb.registered_on_join_team do
				cb.registered_on_join_team[i](player, "terrorist")
			end
			
			local inventorytouse = minetest.get_inventory({ type="player", name=player })
			
			--Feature
			if inventorytouse and not clua.find_itemstack_from(clua.player(player), "rangedweapons:glock17") then
    			inventorytouse:add_item("main", "rangedweapons:glock17")
        		inventorytouse:add_item("main", "rangedweapons:9mm 200")
			end
			main_hud.set_main_terrorist(csgo.team[ttt].count)
			
			player_core.upgrade_to_mode(player, "terrorist.b3d")
			
			playerr:set_armor_groups({fleshy = 120, })
			minetest.set_player_privs(player, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
			
			
			cs_core.can_do_damage(player, "yes") -- Can do damage to every player
			csgo.team[ttt].players[player] = true -- Put that plater in terrorist team. DEF:::={inf="L22", search="terrorist"}
			
			--cs_kill.var.alive_players[ttt] = cs_kill.var.alive_players[ttt] + 1
			
			csgo.send_message(player .. " Joins the Terrorist forces", ttt)
				if terrorists_spawn() then
					poss = terrorists_spawn()
						if playerr then
							--pst = clua.random_position(poss, 2, false)
							playerr:setpos(clua.random_position(poss, 1, false))
						end
				else
					minetest.log("error", "By-Core: No position for terrorists found!")
				end
			end
			end
			
		else
			playerr = minetest.get_player_by_name(player)
			
			csgo.op[player] = true
			csgo.pt[player] = true
			csgo.online[player] = true
			csgo.pot[player] = "terrorist"
			if csgo.team[ttt].count == 0 then
				Player = clua.player(player)
				InvRef = Player:get_inventory()
				InvRef:add_item("main", "bomb")
			end
			csgo.team[ttt].count = csgo.team[ttt].count + 1
			csgo.spect[player] = nil
			
			for i = 1, #cb.registered_on_join_team do
				cb.registered_on_join_team[i](player, "terrorist")
			end

			main_hud.set_main_terrorist(csgo.team[ttt].count)
			
			player_core.upgrade_to_mode(player, "terrorist.b3d")
			
			local inventorytouse = minetest.get_inventory({ type="player", name=player })
			
			--Feature
			if inventorytouse and not clua.find_itemstack_from(clua.player(player), "rangedweapons:glock17") then
    			inventorytouse:add_item("main", "rangedweapons:glock17")
        		inventorytouse:add_item("main", "rangedweapons:9mm 200")
			end
			if playerr then
			playerr:set_armor_groups({fleshy = 120, })
			minetest.set_player_privs(player, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
			end
			
			cs_core.can_do_damage(player, "yes") -- Can do damage to every player
			csgo.team[ttt].players[player] = true -- Put that plater in terrorist team. DEF:::={inf="L22", search="terrorist"}
			
			--cs_kill.var.alive_players[ttt] = cs_kill.var.alive_players[ttt] + 1
			
			csgo.send_message(player .. " Joins the Terrorist forces", ttt)
			if terrorists_spawn() then
			poss = terrorists_spawn()
			if playerr then
					--pst = clua.random_position(poss, 2, false)
					playerr:setpos(clua.random_position(poss, 1, false))
			end
			else
			minetest.log("error", "By-Core: No position for terrorists found!")
			end
		end
	
	
	end
end
end

function csgo.counter(player, force)
local ttt = "counter"
	if ccc(player) then
		empty()
	else
		return
	end
if player then
	if (csgo.op[player] ~= true) then
		if csgo.spect[player] == true then
			--csgo.spectator(player, "joined spectators, reason: Teams Limit has reached or other things....")
			empty()
			--print("debug__#@")
			if csgo.team[ttt].count == 20 then
			empty()
			minetest.log("warning", "Unavailable space for team counters. Ignoring for this time....")
			else
			if force then
			playerr = minetest.get_player_by_name(player)
			
			csgo.spect[player] = nil
			csgo.op[player] = true
			csgo.pt[player] = true
			csgo.online[player] = true
			csgo.pot[player] = "counter"
			
			for i = 1, #cb.registered_on_join_team do
				cb.registered_on_join_team[i](player, "counter")
			end
			
			local inventorytouse = minetest.get_inventory({ type="player", name=player })
			if inventorytouse and not clua.find_itemstack_from(clua.player(player), "rangedweapons:m1991") then
    			inventorytouse:add_item("main", "rangedweapons:m1991")
        		inventorytouse:add_item("main", "rangedweapons:45acp 200")
			end
			
			csgo.team[ttt].count = csgo.team[ttt].count + 1
			
			main_hud.set_main_counter(csgo.team[ttt].count)
			
			player_core.upgrade_to_mode(player, "counter.b3d")
			
			if playerr then
			playerr:set_armor_groups({fleshy = 120, })
			minetest.set_player_privs(player, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
			end
			
			cs_core.can_do_damage(player, "yes") -- Can do damage to every player.
			csgo.team[ttt].players[player] = true -- Put that plater in counter team. DEF:::={inf="L48", search="counter"}
			
			--cs_kill.var.alive_players[ttt] = cs_kill.var.alive_players[ttt] + 1
			
			--core.chat_send_player(player, "E2") -- debug
			csgo.send_message(player .. " Joins the Counter-Terrorist forces", ttt)
				if counters_spawn() then
					poss = counters_spawn()
					if playerr then
						--pst = clua.random_position(poss, 2, false)
						playerr:setpos(clua.random_position(poss, 1, false))
					end
				else
					core.log("error", "By-Core: No position for counters found!")
				end
			end
			end
			
		else
			playerr = minetest.get_player_by_name(player)
			local ttt = "counter"
			
			csgo.spect[player] = nil
			csgo.op[player] = true
			csgo.pt[player] = true
			csgo.online[player] = true
			csgo.pot[player] = "counter"
			
			for i = 1, #cb.registered_on_join_team do
				cb.registered_on_join_team[i](player, "counter")
			end

			csgo.team[ttt].count = csgo.team[ttt].count + 1
			
			local inventorytouse = minetest.get_inventory({ type="player", name=player })
			if inventorytouse and not clua.find_itemstack_from(clua.player(player), "rangedweapons:m1991") then
    			inventorytouse:add_item("main", "rangedweapons:m1991")
        		inventorytouse:add_item("main", "rangedweapons:45acp 200")
			end
			
			main_hud.set_main_counter(csgo.team[ttt].count)
			
			player_core.upgrade_to_mode(player, "counter.b3d")
			
			if playerr then
			playerr:set_armor_groups({fleshy = 120, })
			minetest.set_player_privs(player, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
			end
			
			cs_core.can_do_damage(player, "yes") -- Can do damage to every player.
			csgo.team[ttt].players[player] = true -- Put that plater in counter team. DEF:::={inf="L48", search="counter"}
			
			--cs_kill is obsolete.
			--cs_kill.var.alive_players[ttt] = cs_kill.var.alive_players[ttt] + 1
			
			--core.chat_send_player(player, "E2") -- debug
			csgo.send_message(player .. " Joins the Counter-Terrorist forces", ttt)
			if counters_spawn() then
				poss = counters_spawn()
				if playerr then
					--pst = clua.random_position(poss, 2, false)
					playerr:setpos(clua.random_position(poss, 1, false))
					--error(dump(poss))
				end
			else
				core.log("error", "By-Core: No position for counters found!")
			end
		end
	--elseif force then  -- Force method
		
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
	"label[0.1,8.9; Theres a limit of players in every team Terrorists Limit: 10\n Counters Limit: 10]" ..
	"button[7,1.1;3,7.5;spect;Spectator]" ..
	"image_button[0,1.1;7,7.5;core_counter.png;counterr;Counter Terrorists\nCount: ".. minetest.formspec_escape(csgo.team.counter.count) ..";false;true;core_counterstart.png]" ..
	"image_button[10,1.1;7,7.5;core_terrorist.png;terrorist;Terrorists Forces\nCount: ".. minetest.formspec_escape(csgo.team.terrorist.count) ..";false;true;core_terroriststart.png]" ..
	"image_button_exit[12.1,9.3;3.7,1;invisible.png;autoselect;AutoSelect]"
    }
    
    

    return table.concat(formspec, "")
end

function empty() end







function regdie() 

for _, player in pairs(minetest.get_connected_players()) do
if player then
		core.after(1, function(player)
			player:set_hp(20)
		end, player)
end
end
end

call.register_on_end_match(function()
regdie()

end)


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "core:main" then
        return
    end
		
	if fields.terrorist then
        local pname = player:get_player_name()
        if not csgo.team.terrorist.count == 20 then
        var = "no teams had to join. Because teams limit reached"
        csgo.spectator(pname, var)
        else
        csgo.terrorist(pname) 
        end
        core.close_formspec(pname, "core:main")
    	
    end
    
    if fields.counterr then
        local pname = player:get_player_name()
        if not csgo.team.counter.count == 20 then
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
        csgo.send_message(minetest.colorize("#3491FF", "** " .. param .. " **"), team, name)
        elseif team == "terrorist" then
        csgo.send_message(minetest.colorize("#FFA900", "** " .. param .. " **"), team, name)
        elseif team == "spectator" then
        csgo.send_message(minetest.colorize("#00C200", "** " .. param .. " **"), team, name)
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
    	core.chat_send_player(name, "Terrorists team: Count: "..csgo.team.terrorist.count..", Players: "..table.concat(ch2, ","))
        core.chat_send_player(name, "Counters team: Count: "..csgo.team.counter.count..", Players: "..table.concat(ch1, ","))
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

function terminate(var, pname) -- This has a players act
if pname then
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








function doit()

term_var = math.random(1, 2)
terminate(term_var, name)
core.close_formspec(name, "core:main")

end

defuser_huds = {}

minetest.register_on_joinplayer(function(playerrrr)
	--hb.init_hudbar(playerrrr, "ammo", 0, 140)
	playerrrr:set_hp(20)
	local map_edit = clua.get_bool("map_edit", clua.get_table_value("central_csgo"))
	if not map_edit then
	name = playerrrr:get_player_name()
    	preparenow()
    	core.after(1, function()
    	if csgo.team.terrorist.count == tonumber(csgo.usrTlimit) and csgo.team.counter.count == tonumber(csgo.usrTlimit) then
    	psuh = ("Unavailable teams. Limit reached. Spectator Is available.\n Trying to enter in there while the limit reached will convert into a spectator")
    	end
    	 minetest.show_formspec(name, "core:main", csgo.main(name))
    	end)
    	
    	
    	minetest.register_on_player_receive_fields(function(player, formname, fields)
    	if formname == "core:main" and player == playerrrr then
        return
        else
        minetest.after(10, doit)
    	end
    	
    	end)
    	minetest.after(10, doit) -- hehe, here must be an error but its solved a long time ago in top of this file
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

end)


function csgo.show_menu(player)
	player:set_hp(20)
	
	
	name = player:get_player_name()
    	preparenow()
    	core.after(1, function()
    	if csgo.team.terrorist.count == csgo.usrTlimit and csgo.team.counter.count == csgo.usrTlimit then
    	preparenow("Unavailable teams. Limit reached. Spectator Is available.\n Trying to enter in there while the limit reached will convert into a spectator")
    	end
    	 minetest.show_formspec(name, "core:main", csgo.main(name))
    	end)
    	
    	
    	minetest.register_on_player_receive_fields(function(player, formname, fields)
    	if formname == "core:main" and player == player then
        return
        else
        if player:is_player() then
        minetest.after(10, doit)
        end
    	end
    	
    	end)
    	if player:is_player() then
    	minetest.after(10, doit)
    	end -- hehe, here must be an error but its solved a long time ago in top of this file
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
