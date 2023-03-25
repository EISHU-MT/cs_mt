

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
end
