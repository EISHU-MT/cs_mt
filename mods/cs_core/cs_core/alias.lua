
local map_editor = true

if minetest.settings:get_bool("cs_map.mapmaking", false) ~= true then
minetest.register_alias("mapgen_singlenode", "mcore:air")
end