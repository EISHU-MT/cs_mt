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


























