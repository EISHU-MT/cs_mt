local modpath = core.get_modpath(minetest.get_current_modname())

local S = minetest.get_translator("core")

-- Core 1 Dofiles

version = "V1-ALPHA"
--Initial core settings:
--Cores
--dofile(modpath.."/core3.lua") -- 3ND CORE --- Player Customise
dofile(modpath.."/core1.lua") -- Primary Core

--Core1 dofiles
dofile(modpath.."/cooldown.lua") -- CoolDown MINI-API
dofile(modpath.."/api.lua") -- API
dofile(modpath.."/l_j.lua") -- Leave/Join.
dofile(modpath.."/callbacks.lua") -- Callbacks

--clua.throw("Bad Argument to option `2`: Expected number, got NIL")

-- Second Core
dofile(modpath.."/core2.lua") -- Secondary Core
dofile(modpath.."/on_match.lua")
dofile(modpath.."/central_memory.lua") -- Auto fixer
dofile(modpath.."/hand.lua")
dofile(modpath.."/c4_api.lua")
dofile(modpath.."/bomb.lua")
dofile(modpath.."/formatter.lua")
dofile(modpath.."/defuser.lua")
dofile(modpath.."/defuser_hooks.lua")


--Third Core
dofile(modpath.."/core3.lua")

dofile(modpath.."/alias.lua") -- Aliases


--MODS in core
dofile(modpath.."/cs_match/init.lua")
dofile(modpath.."/cs_timer/init.lua")


--Some functions
dofile(modpath.."/kill_logs.lua")
dofile(modpath.."/lua_mod.lua")
