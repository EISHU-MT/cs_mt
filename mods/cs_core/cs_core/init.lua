local modpath = core.get_modpath(minetest.get_current_modname())

local S = minetest.get_translator("core")

-- Core 1 Dofiles

version = "V2.0 ShootingStars"
--Initial core settings:
--Cores
--dofile(modpath.."/core3.lua") -- Third CORE --- Player Customise
dofile(modpath.."/core1.lua") -- Primary Core

--Core1 dofiles
dofile(modpath.."/cooldown.lua") -- CoolDown MINI-API
dofile(modpath.."/api.lua") -- API
dofile(modpath.."/callbacks.lua") -- Callbacks
dofile(modpath.."/l_j.lua") -- Leave/Join.

--clua.throw("Bad Argument to option `2`: Expected number, got NIL")

-- Second Core
dofile(modpath.."/core2.lua") -- Secondary Core
dofile(modpath.."/on_match.lua")
dofile(modpath.."/central_memory.lua") -- Auto fixer
dofile(modpath.."/hand.lua")
dofile(modpath.."/c4_api.lua")
dofile(modpath.."/bomb.lua")
dofile(modpath.."/on_join_player_hooks.lua")
dofile(modpath.."/formatter.lua")
dofile(modpath.."/defuser.lua")
dofile(modpath.."/defuser_hooks.lua")

dofile(modpath.."/lua_mod.lua")
dofile(modpath.."/if_item.lua")
dofile(modpath.."/rules.lua")
dofile(modpath.."/radio.lua")
dofile(modpath.."/restrictions.lua")
dofile(modpath.."/player_on_walk.lua")
dofile(modpath.."/history.lua")

dofile(modpath.."/score_core.lua")
dofile(modpath.."/score_callbacks.lua")

dofile(modpath.."/bounty.lua")

--Third Core
dofile(modpath.."/core3.lua")

dofile(modpath.."/alias.lua") -- Aliases


--MODS in core
dofile(modpath.."/cs_match/init.lua")
dofile(modpath.."/cs_timer/init.lua")


--Some functions
dofile(modpath.."/kill_logs.lua")



































