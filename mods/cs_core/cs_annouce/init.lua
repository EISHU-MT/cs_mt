annouce = {}
local hud = mhud.init()
function make_dissapear_mess()
for ee, player in pairs(core.get_connected_players()) do
if player then
if hud:exists(player, "winner0x83166") then
hud:remove(player, "winner0x83166")
end
end
end
end


function annouce.winner(team, skill)
if team and skill then
if team == "counter" then
colored = 0x3491FF
teamm = "Counter-Terrorists Wins the Round!\n" .. skill
	
end
if team == "terrorist" then
colored = 0xFFA900
teamm = "Terrorists Wins the Round!\n" .. skill
end

if team == "No winner" then
colored = 0xFF0000
teamm = "No Winner\n" .. skill
end

if team == "spectator" then -- This is so weird .-.
minetest.log("warning", "Exiting of CS:GO Like due an error!")
minetest.log("error", "SPECTATOR can't be a winner/loser team! that team is unplayable!")
error("[CORE]: Spectator *TEAM* can't be a winner/loser team! that team is unplayable, its only for see!")
end
	if type(discord) == "table" then
		discord.send(teamm)
	end
for ee, player in pairs(core.get_connected_players()) do
--print(player, ee)
if player and not hud:exists(player, "winner0x83166") then
hud:add(player, "winner0x83166", {
hud_elem_type = "text",
scale = {x = 100.6, y = 20.6},
position = {x = 0.485, y = 0.21},
offset = {x = 30, y = 100},
size = {x = 2},
alignment = {x = 0, y = -1},
text = teamm,
color = colored,
})
end
minetest.after(5, make_dissapear_mess)
end
end
end