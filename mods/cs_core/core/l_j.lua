--[[ Unused function
temp = {}
local function temp.check_teams_forp()
for team, def in pairs(csgo.team) do
temp[team].count = 0
for players_count in pairs(csgo.team[team].players) do
temp[team].count = temp[team].count + 1
end
end
dofile(modpath.."/settings/join_leave_conf.lua")
end
--]]

--[[ THE V0.0 ENGINE CODE, DO NO UNCOMMENT!!
	for doit, arg1 in pairs(csgo.team) do
		if (temp[doit].count == c_core.var.max_users or temp[doit].count > c_core.var.max_users) -- The second is immposible but ok....
			print("[CORE] Unable to put player  {" .. pname .. "} in " .. doit .. " team. Proceding to put on another team...")
			print("[CORE] Putting her to be a spectator....")
			csgo.spectator(pname)
		else
			print("[CORE] Putting player {" .. pname .. "} in " .. doit)
			csgo[doit](pname)
		end
	end
--]]
--[[
minetest.register_on_joinplayer(function(player)
local pname = player:get_player_name()
for _, player in pairs(core.get_connected_players()) do
if player then
if hud:exists(player, "timerrrr") then
hud:remove(player, "timerrrr")
end
end
end
end)
--]]
--]]
minetest.register_on_leaveplayer(function(player)
	local pname = player:get_player_name()
	if (csgo.online[pname]) then
		he_team = csgo.pot[pname]
		csgo.op[pname] = nil
		csgo.pt[pname] = nil
		csgo.online[pname] = nil
		csgo.spect[pname] = nil
		csgo.pot[pname] = nil
		csgo.team[he_team].count = csgo.team[he_team].count - 1
		csgo.team[he_team].players[pname] = nil
		csgo.pot2[pname] = nil
		--dead[pname] = nil
	end
end)















