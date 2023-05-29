--[[
rtime = 
minetest.register_on_joinplayer(function(player)
	inv_hud = player:hud_add({
	  hud_elem_type = "text",
	  name = "inv_hud",
	  scale = {x = 1.5, y = 1.5},
	  position = {x = 0.485, y = 0.09},
	  offset = {x = 30, y = 100},
	  size = {x = 2},
	  alignment = {x = 0, y = -1},
	  text = "",
	  number = 0xCECECE,
	})
end)



inv_timer = 30

function ctimer.set_inv_timer()
	inv_timer = 30
end

function ctimer.commence_inv()
	inv_timer = inv_timer - DEFAULT_TIME
	if inv_timer == 0 then
		run_anymore = false
		cs_buying.disable_shopping()
		for __, player in pairs(core.get_connected_players()) do
			player:hud_change(inv_hud, "text", "")
		end
	end
	if run_anymore ~= false then
		for __, player in pairs(core.get_connected_players()) do
			if player then
				player:hud_change(inv_hud, "text", inv_timer)
			end
		end
	end
	core.after(1, ctimer.commence_inv)
end
if type(ctimer.commence_inv) == "function" then
	core.after(1, ctimer.commence_inv)
end

]]
--[[
minetest.register_on_joinplayer(function(player)
	local pname = player:get_player_name()
	local inv_timerrr = 30
	function local_t()
		inv_timerrr = inv_timerrr - DEFAULT_TIME
		if inv_timerrr == 0 then
			run_anymoree = false
			cs_buying.disable_shopping(player)
			local_t = nil
		end
		
		if run_anymoree ~= false then
		
			player:hud_change(inv_hud, "text", inv_timerrr)
		
		end
		
		if type(local_t) == "function" then
			core.after(1, local_t)
		end
	end
	if type(local_t) == "function" then
		core.after(1, local_t)
	end
	
	
end)
--]]