summary = {
    
}
local function transform(ae)
	local tabled1 = {}
	for i, a in pairs(ae) do
		table.insert(tabled1, i)
	end
	return tabled1
end

function summary.calculate_players(players_table)
	local table1 = {}
	local table2 = {}
	local table3 = {}
	for i, player in pairs(players_table) do
		if player then
			table.insert(table1, player)
			table2[player:get_player_name()] = kills[player:get_player_name()].kills or 0
			table3[player:get_player_name()] = kills[player:get_player_name()].deaths or 0
		end
	end
    return table1, table2, table3, {}
end
--[[
    players={
        ["nuig"] = player_kills["nuig"] --[[ number- --kills
    }

]]
function summary.add_by_values(players, players_kills, players_deaths, inverse_kills)
	--[[
		this was the hardest thing i did.
	]]
	table.sort(players, function (n1, n2) return players_kills[n1] > players_kills[n2] end)
	--local splayers = players
	uplayers = {}
	for i, str in pairs(players) do
		core.debug("green", "Creating list row: "..i.." for "..str, "CS:GO Summary")
		local ea = csgo.pot[str]
		table.insert(uplayers, "Player "..core.colorize(csgo.team[ea].colour, str).." kills: "..players_kills[str].."\\, deaths: "..players_deaths[str])
	end
	return uplayers
end
--[[
keystring[value]
]]
function summary.show_formspec_to_all()
    --cc = summary.calculate_players(core.get_connected_players())
    calced = summary.add_by_values(summary.calculate_players(transform(kills)))
    
    formspec = {
        "formspec_version[6]" ..
        "size[15,10]" ..
        "box[7.6,0;7.4,1.2;#FFB500]" ..
        "textlist[0.3,2.8;13.3,6.4;null;"..table.concat(calced, ",")..";1;false]" ..
        "box[0.3,2.8;13,6.4;]" ..
        "label[2.3,1.2;CS:GO Summary]" ..
        "label[7.9,0.3;Total deaths of terrorists:]" ..
        "label[8.53,0.8;Total kill of terrorists:]" ..
        "box[7.6,1.2;7.4,1.2;#0099FF]" ..
        "label[7.9,1.5;Total deaths of counters:]" ..
        "label[8.3,2;Total kills of terrorists:]" ..
        "label[13.1,1.2;UNIT@]" ..
        "label[0.3,9.6;Made By EISHU\\, to your Minetest Game Engine]" ..
        "button_exit[7.9,9.3;6.8,0.6;;Exit]"
    }
    conn = table.concat(formspec, "")
    for _, players in pairs(core.get_connected_players()) do
        local pname = players:get_player_name()
        core.show_formspec(pname, "Summary:Summary", conn)
    end
    return true
end
function summary.return_formspec()
    calced = summary.add_by_values(summary.calculate_players(transform(kills)))
    formspec = {
        "formspec_version[6]" ..
        "size[15,10]" ..
        "box[7.6,0;7.4,1.2;#FFB500]" ..
        "textlist[0.3,2.8;13.3,6.4;null;"..table.concat(calced, ",")..";1;false]" ..
        "box[0.3,2.8;13,6.4;]" ..
        "label[2.3,1.2;CS:GO Summary]" ..
        "label[7.9,0.3;Total deaths of terrorists:]" ..
        "label[8.53,0.8;Total kill of terrorists:]" ..
        "box[7.6,1.2;7.4,1.2;#0099FF]" ..
        "label[7.9,1.5;Total deaths of counters:]" ..
        "label[8.3,2;Total kills of terrorists:]" ..
        "label[13.1,1.2;UNIT@]" ..
        "label[0.3,9.6;Made By EISHU\\, to your Minetest Game Engine]" ..
        "button_exit[7.9,9.3;6.8,0.6;;Exit]"
    }
    conn = table.concat(formspec, "")
    return conn
end
minetest.register_chatcommand("summary", {
	func = function(name, param)
		core.show_formspec(name, "Summary:Summary", summary.return_formspec())
	end,
})
minetest.register_chatcommand("s", {
	func = function(name, param)
		core.show_formspec(name, "Summary:Summary", summary.return_formspec())
	end,
})
call.register_on_new_matches(function()
	summary.show_formspec_to_all()
end)