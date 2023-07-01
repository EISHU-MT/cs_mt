radio = {
	delay = {},
	storage = minetest.get_mod_storage("core"),
	msgs = { -- category
		heard_something = {
			"I heard something...",
			"There is a loud noise nearby",
			"Someone is making noise",
			"I heard something suspicious",
		},
		hurted = {
			"Aaaah! Any help here!",
			"Help me, please!",
			"Help!",
			"Someone is shootinh at me!",
			"The enemy is killing me!",
		},
		hurted_by_teammate = {
			"Stop!",
			"I'm not an enemy!",
			"Halt!",
			"Shoot the enemy, not me!"
		},
		going_to_b = {
			"I am going to Sector B",
			"I'm moving to Sector B",
		},
		going_to_a = {
			"I am going to Sector A",
			"Im moving to Sector A",
		},
		reached_to_the_bomb = {
			"I found the bomb!",
			"I discovered the bomb",
			"I am near the bomb",
			"I found the bomb area!",
		},
		what_happening = { -- Random msgs
			"What is happening?",
			"What happened?",
		},
		i_got_it = {
			"I got it!",
			"Got it!",
		},
		ill_die = {
			"Help! I'm going to die!",
			"No! I'm dying!",
			"I'm going to be a ghost!",
		},
	},
	types = {
		"1. Heard Something Nearby",
		"2. Hurt",
		"3. Attacked by Teammate",
		"4. Moving to Sector B",
		"5. Moving to Sector A",
		"6. Found the Bomb",
		"7. What is happening?",
		"8. I've got it!",
		"9. I'm gonna die!",
	},
	people = {}
}


function radio.send_msg(team, msg, p)
	n = Name(p) or " "
	if team and csgo.team[team] and msg and n then
		for name in pairs(csgo.team[team].players) do
			if Player(name) then
				--if radio.return_igns_players()[name] ~= true then
				core.chat_send_player(name, core.colorize("#FFEF00", "["..n.."RADIO ] ")..msg or "~NULL")
				--end
			end
		end
	end
end

function radio.select_random_msg(category)
	if type(radio.msgs[category]) == "table" then
		local value = #radio.msgs[category]
		local svalue = math.random(value)
		return radio.msgs[category][svalue] or "null"
	else
		core.log("error", "Cannot find a category called: "..tostring(category))
	end
end

function radio.get_category_by_num(number) -- Start of menu core (This may crash if edited)
	if number == 1 then
		category = "heard_something"
	elseif number == 2 then
		category = "hurted"
	elseif number == 3 then
		category = "hurt_by_teammate"
	elseif number == 4 then
		category = "going_to_b"
	elseif number == 5 then
		category = "going_to_a"
	elseif number == 6 then
		category = "reached_to_the_bomb"
	elseif number == 7 then
		category = "what_happening"
	elseif number == 8 then
		category = "i_got_it"
	elseif number == 9 then
		category = "ill_die"
	else
		category = "what_happening"
	end
	
	return category
end -- End of menu core

function radio.send_to_player(player)
	core.show_formspec(Name(player), "radio:radio", "formspec_version[6]" .. "size[10.5,11]" .. "box[0,0;10.7,1;#FFFF00]" .. "label[0.2,0.4;Radio]" .. "button_exit[0.1,10;10.3,0.9;send;Send]" .. "textlist[0.1,1.8;10.3,8.1;list;"..table.concat(radio.types, ",")..";-1;false]" .. "label[3.8,1.4;Please select one]")
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "radio:radio" then
		return
	end
	if fields.list then
		local t = core.explode_textlist_event(fields.list)
		if t.type ~= "DCL" then
			if radio.types[t.index] then
				local category = radio.get_category_by_num(t.index)
				core.chat_send_player(Name(player), "Selected: "..radio.select_random_msg(category))
				radio.people[Name(player)] = category
			end
		end
	end
	if fields.send then
		if radio.people[Name(player)] then
			radio.send_msg(csgo.pot[player:get_player_name()], radio.select_random_msg(radio.people[Name(player)]), " <"..player:get_player_name().."> ")
			radio.people[Name(player)] = nil
		else
			core.chat_send_player(Name(player), "-!- Nothing selected.")
		end
	end
end)


local radio_def = {
		params = "<number>",
		description = "Send any message via radio",
		func = function(name, param)
			if param and param ~= "" and param ~= " " then
				local n = tonumber(param)
				if n then
					if n > 9 then
						n2 = 9
					elseif n < 1 then
						n2 = 1
					else
						n2 = n
					end
					if not n2 then
						n2 = 7
					end
					local category = radio.get_category_by_num(n2)
					radio.send_msg(csgo.pot[name], radio.select_random_msg(category or "what_happening"), " <"..name.."> ")
				end
			else
				radio.send_to_player(name)
			end
		end,
	}

core.register_chatcommand("radio", radio_def)



























