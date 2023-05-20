-- History
history = {}
call.register_on_player_join_team(function(player, team)
	local name = Name(player)
	history[name] = team -- remember in what team the player was
end)
call.register_on_new_match(function()
	history = {} -- Clear history
end)
local rm_player_from_history = {
	params = "<name>",
	description = "Remove a player or (yourself) from history (History of joining teams)",
	privs = {core=true},
	func = function(name, param)
		if param then
			history[param] = nil
		else
			history[name] = nil
		end
	end,
}
core.register_chatcommand("rmh", rm_player_from_history)