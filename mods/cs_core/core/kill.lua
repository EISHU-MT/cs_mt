--Register Killings
--[[
minetest.register_on_punchplayer(function(player, hitter, arg1, arg2, arg3, damage) -- arg1 arg2 arg3 is not used,
	local noh = {pname=hitter:get_player_name(), pid=hitter} -- Ign pid value
	local nov = {pname=player:get_player_name(), pid=player}
	local noe = {pname=hitter, pid=false} -- Used if a non-player entity punched a victim. Like mobs
	local toh = csgo.pot[noh.pname]
	local tov = csgo.pot[nov.pname]
	if (toh == tov) then
	if player:get_hp() > 0 and player:get_hp()-damage <= 0 and hitter then
	hud_events.new(noh, {
		text = "You killed your teammate!",
		color = "danger",
		quick = true,
	})
	else
	hud_events.new(noh, {
		text = nov .. " is your teammate!",
		color = "warning",
		quick = true,
	})
	end
	else
	cs_core.register_death("list", noh, nov)
	end
end)
]]





























