local maker = clua.get_bool("map_edit", clua.get_table_value("central_csgo"))

if maker then
	map_maker = {}
	map_edit = true
	local modpath = minetest.get_modpath(minetest.get_current_modname()) .. "/"
	dofile(modpath .. "gui.lua")
	dofile(modpath .. "map_maker.lua")
end