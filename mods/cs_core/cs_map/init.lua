cs_map = {}

function cs_map.get_team_relative_z(player)
	local name = player:get_player_name()
	local tname = csgo.pot[player]
	return (tname == "terrorist" and 1 or -1) * player:get_pos().z
end

-- Convenience function to check whether a file (or multiple files) exists in mapdir
function cs_map.file_exists(subdir, target)
	local list = minetest.get_dir_list(cs_map.mapdir .. subdir, false)
	if type(target) == "string" then
		return table.indexof(list, target) ~= -1
	elseif type(target) == "table" then
		for _, filename in pairs(target) do
			if table.indexof(list, filename) == -1 then
				return false
			end
		end
		return true
	end
end

-- Overridden by server mods
function cs_map.can_cross(player)
	return false
end

modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath .. "/emerge.lua")
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/barrier.lua")
	dofile(modpath .. "/base.lua")
	dofile(modpath .. "/meta_helpers.lua")
	dofile(modpath .. "/schem_map.lua")


