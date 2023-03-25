
local map_editor = true

if clua.get_bool("map_edit", clua.get_table_value("central_csgo")) ~= true then
minetest.register_alias("mapgen_singlenode", "core:air")
end