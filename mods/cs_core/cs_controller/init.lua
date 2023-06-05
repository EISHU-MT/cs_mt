local enable = minetest.settings:get_bool("cs_core", true)
if enable == false then
	error("Cs:Mt Engine is disabled!")
end