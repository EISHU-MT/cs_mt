-- Cooldowns for CS:GO, like it is used for main menu. (DEPRECATED)
local clock = os.clock
function cs_core.cooldown(n)-- seconds
local t0 = clock()
while clock() - t0 <= n do end
end
--Basics
-- Bad response function.
--[[
function cs_core.repeat_funct(time, funct, arg1, svar, svar_arg1)
if time and funct then
for i = 1, time do
funct(agr1) -- breh
cs_core.cooldown(1)
if second_var then
if svar_arg1 then
svar(svar_arg1)
else
svar()
end
end
end
end
end
--]]


