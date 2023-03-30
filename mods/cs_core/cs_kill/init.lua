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
minetest.register_on_player_hpchange(function(player, hp_change, reason)
end)

