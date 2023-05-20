-- Stats for cs:mt
local start = minetest.settings:get_bool("cs_core.enable_player_stats", true)
local storage = core.get_mod_storage("cs_stats")

if start ~= true then
	core.log("warning", "Stats is disabled, the current kills of players & players deaths will dont be saved!")
	return
end

stats = {
	deaths = {
		add_to = function(player)
			if player and player ~= "" then
				local strs =  core.deserialize(storage:get_string("deaths"))
				if not strs[player] then
					strs[player] = 0
				end
				strs[player] = strs[player] + 1
				local sr = core.serialize(strs)
				storage:set_string("deaths", sr)
			end
		end,
	},
	kills = {
		add_to = function(player)
			if player and player ~= "" then
				local strs =  core.deserialize(storage:get_string("kills"))
				if not strs[player] then
					strs[player] = 0
				end
				strs[player] = strs[player] + 1
				local sr = core.serialize(strs)
				storage:set_string("kills", sr)
			end
		end,
	},
	bplanted = {
		add_to = function(player)
			if player and player ~= "" then
				local strs =  core.deserialize(storage:get_string("bomb_players"))
				if not strs[player] then
					strs[player] = 0
				end
				strs[player] = strs[player] + 1
				local sr = core.serialize(strs)
				storage:set_string("bomb_players", sr)
			end
		end,
	},
	player = {
		calculate_kd = function(player)
			local function empty() end
			if player and player ~= "" then empty() else return 0 end
			local kill = core.deserialize(storage:get_string("kills"))
			local death = core.deserialize(storage:get_string("deaths"))
			local kn = kill[player] or 0
			local dn = death[player] or 0
			local to_return = kn / dn or 0
			return to_return or 0
		end,
		get_deaths = function(player)
			local function empty() end
			if player and player ~= "" then empty() else return 0 end
			local death = core.deserialize(storage:get_string("deaths"))
			local dn = death[player] or 0
			return dn
		end,
		get_kills = function(player)
			local function empty() end
			if player and player ~= "" then empty() else return 0 end
			local kill = core.deserialize(storage:get_string("kills"))
			local kn = kill[player] or 0
			return kn
		end,
		get_bplanted = function(player)
			local function empty() end
			if player and player ~= "" then empty() else return 0 end
			local bombs = core.deserialize(storage:get_string("bomb_players"))
			local b = bombs[player] or 0
			return b
		end,
	},
}

-- If storage dont had saved the kills and deaths, this starts a new table with `__null`
do
	local strs = storage:get_string("kills")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = 0
				}
		local sr = core.serialize(newtable)
		storage:set_string("kills", sr)
	end
	strs = storage:get_string("deaths")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = 0
				}
		local sr = core.serialize(newtable)
		storage:set_string("deaths", sr)
	end
	strs = storage:get_string("bomb_players")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = 0
				}
		local sr = core.serialize(newtable)
		storage:set_string("bomb_players", sr)
	end
end

-- Register when a player is being added to summary to add
call.register_on_add_killer(function(victim, killer, tabled)
	if victim and victim ~= "" then
		stats.deaths.add_to(victim)
		if killer and killer ~= "" then
			stats.kills.add_to(killer)
		end
	end
end)
c4.register_on_bomb_explode(function(planter)
	stats.bplanted.add_to(planter or "")
end)
-- Commands

--[[
	{
		params = "<name> <privilege>",  -- Short parameter description
		description = "Remove privilege from player",  -- Full description
		privs = {privs=true},  -- Require the "privs" privilege to run
		func = function(name, param),
	}
--]]

s = core.chat_send_player
c = core.colorize

local rank_definition = {
		params = "<name>",
		description = "Get rank of a player or yourself",
		func = function(name, param)
			if param and param ~= "" then
				local players = csgo.uncompress_players() -- May take a while if our server is overused!
				if players[param] then
					local kn = stats.player.get_kills(param)
					local dn = stats.player.get_deaths(param)
					local bp = stats.player.get_bplanted(param)
					local kd = stats.player.calculate_kd(param)
					local n = tonumber
					s(name, c("#42BE00", "=====Player  Stats====="))
					s(name, c("#42BE00", "Kills: ")..c("#FF3A3A", n(kn)))
					s(name, c("#42BE00", "Deaths: ")..c("#FF3A3A", n(dn)))
					s(name, c("#42BE00", "Planted Bombs: ")..c("#FF9100", n(bp)))
					s(name, c("#42BE00", "K/D: ")..c("#FF3A3A", n(kd)))
					s(name, c("#42BE00", "==End of Player Stats=="))
					return
				else
					core.chat_send_player(name, "The player "..param.." dont exists")
					return
				end
			else
				local players = csgo.uncompress_players()
				if not players[name] then
					core.chat_send_player(name, "You arent found in cs:mt database, this maybe be a bug. Please report it!")
					return
				end
				local kn = stats.player.get_kills(name)
				local dn = stats.player.get_deaths(name)
				local bp = stats.player.get_bplanted(name)
				local kd = stats.player.calculate_kd(name)
				local n = tostring
				s(name, c("#42BE00", "=====Player  Stats====="))
				s(name, c("#42BE00", "Kills: ")..c("#FF3A3A", n(kn)))
				s(name, c("#42BE00", "Deaths: ")..c("#FF3A3A", n(dn)))
				s(name, c("#42BE00", "Planted Bombs: ")..c("#FF9100", n(bp)))
				s(name, c("#42BE00", "K/D: ")..c("#FF3A3A", n(kd)))
				s(name, c("#42BE00", "==End of Player Stats=="))
			end
		end,
	}

minetest.register_chatcommand("r", rank_definition)
minetest.register_chatcommand("rank", rank_definition)
























