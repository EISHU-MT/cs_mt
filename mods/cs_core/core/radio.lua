radio = {
	delay = {},
	storage = minetest.get_mod_storage("core"),
	msgs = { -- category
		heard_something = {
			"I heard something...",
			"Theres a loud sound near me",
			"someone hiding loudly",
			"A suspicius sound i heard",
		},
		hurted = {
			"Aaaah! Any help here!",
			"I need help!",
			"Help!",
			"Someone shooting at me!",
			"Someone of enemy team is hurting me!",
		},
		hurted_by_teammate = {
			"Stop!",
			"Im not an enemy!",
			"U better stop",
		},
		going_to_b = {
			"I am near at Sector B",
			"Im going to Sector B",
		},
		going_to_a = {
			"I am near from Sector A",
			"Im reaching Sector A",
		},
		reached_to_the_bomb = {
			"I found the bomb!",
			"I reached to the bomb",
			"I am near at the bomb",
			"I got at bomb area!",
		},
		what_happening = { -- Random msgs
			"What happening",
			"What happened",
		},
		throw_flash = {
			"I throwed the flashbang",
			"I put flashbang at this area!",
		},
		throw_grenade = {
			"dropped grenade, do not get near it!",
			"i dropt a grenade at this area!",
			"i put a grenade at this area",
		},
		throw_smoke = {
			"Smoke!",
			"A big big cloud is appearing at this area",
			"I dropt smoke!",
		},
		i_got_it = {
			"I got it!",
			"Got it!",
		},
		ill_die = {
			"Aaaaah! Noooo! ill dieee!",
			"Nooo!",
			"Ill become ghosttt!",
		},
		got_kill = {
			"I got ",
			"Got ",
		},
	},
	dtimer1 = 0,
	dtimer2 = 0,
	wait_again = false,
}
do
	local strs = radio.storage:get_string("radio_ign_players")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = true
				}
		local sr = core.serialize(newtable)
		radio.storage:set_string("radio_ign_players", sr)
	end
end
function radio.return_igns_players()
	return core.deserialize(radio.storage:get_string("radio_ign_players")) or {}
end

function radio.send_msg(team, msg, p)
	n = Name(p) or ""
	if team and csgo.team[team] and msg and n then
		for name in pairs(csgo.team[team].players) do
			if core.player_exists(name) then
				--if radio.return_igns_players()[name] ~= true then
				core.chat_send_player(name, core.colorize("#FFEF00", n.."[RADIO] ")..msg or "~NULL")
				--end
			end
		end
	end
end

function radio.select_random_msg(category)
	if type(radio.msgs[category]) == "table" then
		local value = #radio.msgs.category[category]
		local svalue = math.random(value)
		return radio.msgs.category[category][svalue] or "null"
	else
		core.log("error", "Cannot find a category called: "..tostring(category))
	end
end


function radio.on_kill(player, player_team, killer)
	if player and players_team and killer then
		radio.send_msg(csgo.check_team(killer), radio.select_random_msg("got_kill")..player, tostring(killer).." ")
	end
end

radio.table1 = {} -- Table with all players
radio.table2 = {} -- Table with all players position maked with vector.distance() between c4 position if it exists
radio.table3 = {test__ = 9000} -- Table with all players position maked with vector.distance() between c4 position if it exists (2)

function radio.on_step(dtime)
	radio.dtimer1 = radio.dtimer1 + dtime
	radio.dtimer2 = radio.dtimer2 + dtime
	
	radio.table1 = core.get_connected_players()
	for _, player in pairs(radio.table1) do
		radio.table2[Name(player)] = vector.distance(Player(player):get_pos(), c4.pos)
	end
	
	if radio.dtimer1 >= 0.5 then
		if c4.planted and radio.wait_again ~= true then
			for name, value in pairs(radio.table2) do
				if core.player_exists(name) and value and csgo.check_team(name) == "counter" then
				print(value)
				print(csgo.check_team(name))
				print(vector.distance(Player(player):get_pos(), c4.pos))
					if value < vector.distance(Player(player):get_pos(), c4.pos) then
						if vector.distance(Player(player):get_pos(), c4.pos) <= 10 then
							radio.send_msg("counter", radio.select_random_msg("reached_to_the_bomb"), name.." ")
							radio.wait_again = true
						end
					end
				end
			end
		end
		radio.dtimer1 = 0
	end
	
	if radio.dtimer2 >= 2 then
		if radio.wait_again then
			radio.wait_again = false
		end
		radio.dtimer2 = 0
	end
end

core.register_globalstep(radio.on_step)

































