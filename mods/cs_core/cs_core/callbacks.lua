cb = {
    registered_on_new_match = {},
    registered_on_end_match = {},
    registered_on_join_team = {},
    registered_on_end_time = {},
    registered_on_new_matches = {},
    registered_on_kill = {},
    registered_on_timer_commence = {},
}
call = {}
--Register on new match
function call.register_on_new_match(func)
	table.insert(cb.registered_on_new_match, func)
end
--Register on reset settings and new match:
function call.register_on_new_matches(func)
	table.insert(cb.registered_on_new_matches, func)
end
--Register on end match
function call.register_on_end_match(func)
	table.insert(cb.registered_on_end_match, func)
end
--Register when a player join teams
function call.register_on_player_join_team(func)
	table.insert(cb.registered_on_join_team, func)
end
--Register on end time
function call.register_on_end_time(func)
	table.insert(cb.registered_on_end_time, func)
end
--Register on kill players
function call.register_on_kill_player(func)
	table.insert(cb.registered_on_kill, func)
end
-- Register when the timer commences match
function call.register_on_timer_commence(func)
	table.insert(cb.registered_on_timer_commence, func)
end
csgoc = call