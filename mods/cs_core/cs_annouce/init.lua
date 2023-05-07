annouce = {}
local hud = mhud.init()
function make_dissapear_mess()
	for name, value in pairs(annouce.huds) do
		if name then
			local player = Player(name)
			local pname  = Name(name)
			if player then
				player:hud_remove(value)
			end
		end
	end
end

function annouce.publish_to_players(msg, colored)
	for ee, player in pairs(core.get_connected_players()) do
		if player then
			annouce.huds[Name(player)] = player:hud_add({
			hud_elem_type = "text",
			scale = {x = 100.6, y = 20.6},
			position = {x = 0.485, y = 0.21},
			offset = {x = 30, y = 100},
			size = {x = 2},
			alignment = {x = 0, y = -1},
			text = msg,
			number = colored,
			})
		end
	end
end
annouce.huds = {}

function annouce.winner(team, skill)
	if team and skill then
		if team == "counter" then
			colored = 0x3491FF
			teamm = "Counter-Terrorists Wins the Round!\n" .. skill
			team2 = "Counter-Terrorists"
		end
		if team == "terrorist" then
			colored = 0xFFA900
			teamm = "Terrorists Wins the Round!\n" .. skill
			team2 = "Terrorists"
		end

		if team == "No winner" then
			colored = 0xFF0000
			teamm = "No Winner\n" .. skill
			team2 = "None"
		end

		if team == "spectator" then -- This is so weird .-.
			minetest.log("warning", "Exiting of CS:GO Like due an error!")
			minetest.log("error", "SPECTATOR can't be a winner/loser team! that team is unplayable!")
			error("[CORE]: Spectator *TEAM* can't be a winner/loser team! that team is unplayable, its only for see!")
		end
		if type(discord) == "table" then
			discord.send("**"..team2.." Wins the Round!**\n"..skill)
		end
		annouce.publish_to_players(teamm, colored)
	end
	
	core.after(5, make_dissapear_mess)
end