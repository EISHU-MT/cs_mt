-- This core notices every thing to discord for security
old_on_log = minetest.log
function minetest.log(typeo, ...)
    --core.after(1, function()
        if clua.send_text then
            if typeo == "action" then
                typed = "italic"
            elseif typeo == "warning" then
                typed = "bold"
            elseif typeo == "error" then
                typed = "bold_italic"
            end
            if typed == nil or typed == " " or typed == "" then
                typed = "none"
            end
            
            clua.send_text(..., typed, typeo)
        end
        old_on_log(typeo, ...)
   -- end, ...)
end
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

























