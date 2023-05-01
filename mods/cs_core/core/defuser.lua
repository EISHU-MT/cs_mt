--Defuser
defuser_hooks_wait = 5
defuser_hooks_wait2 = 7

minetest.register_craftitem("core:defuser", {
	description = "Defuser\n only counters can had this.",
	inventory_image = "defuser.png",
	--[[on_use = function(item, player)
		local inf = clua.get_player_inf(player)
		local pos = inf.pos --link
			if ask_for_bomb() then
				if c4.get_status() then -- if the bomb is planted or not!
					statspawn = c4.pos
					if pos.x < statspawn.x + 2 and pos.x > statspawn.x - 2 and pos.y < statspawn.y + 2 and pos.y > statspawn.y - 2 and pos.z < statspawn.z + 2 and pos.z > statspawn.z - 2 then
						function defuser_interrupted()
							return false
						end
						clua.global("defuser_guy", player:get_player_name())
						his_hud = player:hud_add({
								hud_elem_type = "text",
								name = "defuser_timer",
								scale = {x = 1.5, y = 1.5},
								position = {x = 0.5, y = 0.5},
								offset = {x = 0, y = 20},
								--size = {x = 2},
								alignment = {x = "center", y = "down"},
								--alignment = {x = 0, y = -1},
								text = "Defusing! this will took 5 secs",
								number = 0xCECECE,
						})
						core.after(5, function(user)
							if (defuser_interrupted() == false) then
								annouce.winner("counter", "Congrats to "..user:get_player_name().." for defusing the bomb!")
								cs_match.finished_match(csgo.pot[user:get_player_name()])
								to_end = nil
								user:hud_remove(his_hud)
							end
						end, player)
					else
						hud_events.new(player, {
							text = "(!) Not near at the bomb!",
							color = "warning",
							quick = true,
						})
					end
				else
					hud_events.new(player, {
						text = "(!) The bomb inst planted!",
						color = "warning",
						quick = true,
					})
				end
			else
				hud_events.new(player, {
					text = "(!!) Its illegal to use defuser on a map that has bomb_planting disabled!\n -CLua",
					color = "danger",
					quick = true,
				})
				invv = player:get_inventory()
				invv:remove_item("main", item)
			end
		
	end,--]]
	on_drop = function(itm, drp, pos)
		hud_events.new(drp, {
			text = "(!) Cant drop a defuser!",
			color = "warning",
			quick = true,
		})
	end,
	on_pickup = function(_, lname, table)
		error("core/defuser.lua: line 19: Defuser have been dropped, on pickup: <= on drop!")
	end,
})