cshud = {
    terrorist = {number=0},
    counter = {number=0},
}
timehud = {}
chud_round = {}
thud_round = {}
minetest.register_on_joinplayer(function(ObjectRef, last_login)
	pname = ObjectRef:get_player_name()
	ObjectRef:hud_add({
		hud_elem_type = "image",
		name = "defuser_timer",
		scale = {x = 4.2, y = 4.2},
		position = {x = 0.5, y = 0},
		offset = {x = 0, y = 30},
		--size = {x = 2},
		alignment = {x = "center", y = "up"},
		--alignment = {x = 0, y = -1},
		text = "up_hud.png",
		--number = 0xCECECE,
	})
	timehud[pname] = ObjectRef:hud_add({
		hud_elem_type = "text",
		name = "n",
		scale = {x = 1.5, y = 1.5},
		position = {x = 0.5, y = 0},
		offset = {x = 0, y = 20},
		size = {x = 2},
		alignment = {x = "center", y = "up"},
		--alignment = {x = 0, y = -1},
		text = "*00:00*",
		number = 0xCECECE,
	})
	chud_round[pname] = ObjectRef:hud_add({
		hud_elem_type = "text",
		name = "hud_rounds",
		scale = {x = 1.5, y = 1.5},
		position = {x = 0.51, y = 0.047},
		offset = {x = 0, y = 20},
		size = {x = 2},
		alignment = {x = "center", y = "up"},
		text = " ",
		number = 0x4646FF,
	})
	null = ObjectRef:hud_add({
		hud_elem_type = "text",
		name = "hud_rounds",
		scale = {x = 1.5, y = 1.5},
		position = {x = 0.5, y = 0.047},
		offset = {x = 0, y = 20},
		size = {x = 2},
		alignment = {x = "center", y = "up"},
		text = "/",
		number = 0x000000,
	})
	thud_round[pname] = ObjectRef:hud_add({
		hud_elem_type = "text",
		name = "hud_rounds",
		scale = {x = 1.5, y = 1.5},
		position = {x = 0.49, y = 0.047},
		offset = {x = 0, y = 20},
		size = {x = 2},
		alignment = {x = "center", y = "up"},
		text = " ",
		number = 0xFF9546,
	})
end)

call.register_on_end_match(function(team)

if team == "counter" then
    cshud.counter.number = cshud.counter.number + 1
    core.debug("action", "Counter Terrorist Forces wins!")
elseif team == "terrorist" then
    cshud.terrorist.number = cshud.terrorist.number + 1
    core.debug("action", "Terrorist Forces wins!")
elseif team == "spectator" then
    cs_core.log("error", "cs_hud mod: *spectator* team cant be a winner, returning as an error")
    error("***Spectator team cant be the winner!")
end

end)

call.register_on_new_matches(function()
    cshud.terrorist.number = 0
    cshud.counter.number = 0
end)


minetest.register_globalstep(function(dtime)
	for _, player in pairs(core.get_connected_players()) do
		pname = player:get_player_name()
		player:hud_change(thud_round[pname], "text", tostring(cshud.terrorist.number))
		player:hud_change(chud_round[pname], "text", tostring(cshud.counter.number))
	end
end)