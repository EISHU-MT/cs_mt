
restart = false
restartm = "This server is being restarted from operator request"
-- Restart on finish all matchs
core.register_chatcommand("queue_restart", {
	description = "Restart server on finish all matchs",
	params = "<message",
	func = function(name, param)
        --Param is optional
        restart = true
        if param then
            restartm = param
        else
            restartm = "This server is being restarted from operator request"
        end
    end,
	privs = {server=true, core=true}
})
call.register_on_new_matches(function()
    if restart then
        core.request_shutdown(restartm)
    end
end)

























