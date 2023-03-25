cs_core.log("action", "Initialising Database...")
local modpath = minetest.get_modpath("cs_files")
mp = {}
files = {}
for arg792, directories in pairs(core.get_dir_list(modpath)) do
files[directories] = modpath .. "/" .. directories -- modpath = /home/user/.minetest/games/csgo/mods/cs-core/cs_files/then /home/user/.minetest/games/csgo/mods/cs-core/cs_files/[directories]
cs_core.log("action", "Added directory {" .. directories .. "}" )
end