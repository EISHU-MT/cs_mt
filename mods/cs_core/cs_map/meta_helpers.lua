------------
-- SKYBOX --
------------
function cs_map.skybox_exists(subdir)
	return cs_map.file_exists(subdir, {
		"skybox_1.png",
		"skybox_2.png",
		"skybox_3.png",
		"skybox_4.png",
		"skybox_5.png",
		"skybox_6.png"
	})
end
local function set_skybox(player)
	if cs_map.map.skybox then
		local prefix = cs_map.map.dirname .. "_skybox_"
		local skybox_textures = {
			prefix .. "1.png",  -- up
			prefix .. "2.png",  -- down
			prefix .. "3.png",  -- east
			prefix .. "4.png",  -- west
			prefix .. "5.png",  -- south
			prefix .. "6.png"   -- north
		}
		player:set_sky(0xFFFFFFFF, "skybox", skybox_textures, false)
	else
		player:set_sky(0xFFFFFFFF, "regular", {}, true)
	end
end

-------------
-- PHYSICS --
-------------

local function update_physics(player)
	player:set_physics_override({
		speed   = cs_map.map.phys_speed   or 1,
		jump    = cs_map.map.phys_jump    or 1,
		gravity = cs_map.map.phys_gravity or 1
	})
end

----------
-- TIME --
----------

local BASE_TIME_SPEED = 72

local function update_time()
	local time = cs_map.map.start_time
	local mult = cs_map.map.time_speed or 1
	if time then
		minetest.set_timeofday(time)
	else
		minetest.set_timeofday(0.4)
	end

	minetest.settings:set("time_speed", BASE_TIME_SPEED * mult)
end

---------------
-- CALLBACKS --
---------------


function cs_map.update_env()
	if not cs_map.map then
		return
	end
	update_time()
	for _, player in pairs(core.get_connected_players()) do
		set_skybox(player)
		update_physics(player)
	end
end
