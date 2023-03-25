cshud = {
    terrorist = {number=0},
    counter = {number=0},
}
minetest.register_on_joinplayer(function(ObjectRef, last_login)
    chud_round = ObjectRef:hud_add({
        hud_elem_type = "text",
        name = "hud_rounds",
        scale = {x = 1.5, y = 1.5},
         position = {x = 0.460, y = 0.12},
        offset = {x = 30, y = 100},
        size = {x = 2},
        alignment = {x = 0, y = -1},
        text = cshud.counter.number.." /",
        number = 0x491FF,
    })
    null = ObjectRef:hud_add({
        hud_elem_type = "text",
        name = "hud_rounds",
        scale = {x = 1.5, y = 1.5},
         position = {x = 0.475, y = 0.12},
        offset = {x = 30, y = 100},
        size = {x = 2},
        alignment = {x = 0, y = -1},
        text = "/",
        number = 0x000000,
    })
    thud_round = ObjectRef:hud_add({
        hud_elem_type = "text",
        name = "hud_rounds",
        scale = {x = 1.5, y = 1.5},
         position = {x = 0.490, y = 0.12},
        offset = {x = 30, y = 100},
        size = {x = 2},
        alignment = {x = 0, y = -1},
        text = cshud.terrorist.number,
        number = 0xFFA900,
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
        player:hud_change(thud_round, "text", cshud.terrorist.number)
        player:hud_change(chud_round, "text", cshud.counter.number)
    end
end)