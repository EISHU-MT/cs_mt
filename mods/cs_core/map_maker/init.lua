local maker = minetest.settings:get_bool("cs_map.mapmaking", false)

if maker then
	map_maker = {}
	map_edit = true
	local modpath = minetest.get_modpath(minetest.get_current_modname()) .. "/"
	dofile(modpath .. "gui.lua")
	dofile(modpath .. "map_maker.lua")
end