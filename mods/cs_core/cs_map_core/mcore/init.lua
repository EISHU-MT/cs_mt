-- CS Maps core v2
--[[
	License: ../../../../Licenses.txt
--]]

maps = {
	reg_maps = {},
	func_maps = {},
	maps_name = {},
	current_map = {},
	next_map = {},
	on_load = {},
}
cmaps = {
	enable = minetest.settings:get_bool("cs_map.mapmaking", false),
	modpath = minetest.get_modpath(minetest.get_current_modname()),
	enable_debug = minetest.settings:get_bool("cs_core.enable_env_debug", false)
}

function log(act, msg)
	if cmaps.enable_debug then
		core.log(act, msg)
	end
end


log("info", "Starting Maps core")
dofile(cmaps.modpath.."/proccesor.lua")
dofile(cmaps.modpath.."/core.lua")
dofile(cmaps.modpath.."/essential.lua")
dofile(cmaps.modpath.."/api.lua")

if cmaps.enable then
	dofile(cmaps.modpath.."/mm/map_maker.lua")
	dofile(cmaps.modpath.."/mm/gui.lua")
end