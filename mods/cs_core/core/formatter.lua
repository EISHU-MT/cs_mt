core.register_on_chat_message(function(player, message)
    pname = player
    local checked = false--clua.contact_with("AI", "check_string_content_by_caps_and_cursing", message)
    if checked == false or checked == nil then
        if died[pname] then
            local med = core.colorize("#FFD900", "[DIED]")
            core.chat_send_all(med.." <"..pname.."> "..message)
        elseif csgo.spect[pname] then
            local med = core.colorize("#FFD900", "[SPECT]")
            core.chat_send_all(med.." <"..pname.."> "..message)
        elseif csgo.pot[pname] and csgo.pot[pname] ~= "spectator" then
            local ea = csgo.pot[pname]
            local med = core.colorize(csgo.team[ea].colour, "<"..pname..">")
            core.chat_send_all(med.." "..message)
        else
            core.chat_send_all("<"..pname.."> "..message)
        end
    end
    return true
end)