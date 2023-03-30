--Defuser
minetest.register_craftitem("core:defuser", {
	description = "Defuser\n only counters can had this.",
	inventory_image = "defuser.png",
	on_use = function(item, player)
		local inf = clua.get_player_inf(player)
		local pos = inf.pos --link
			if c4.get_status() then -- if the bomb is planted or not!
				statspawn = c4.pos
				if pos.x < statspawn.x + 2 and pos.x > statspawn.x - 2 and pos.y < statspawn.y + 2 and pos.y > statspawn.y - 2 and pos.z < statspawn.z + 2 and pos.z > statspawn.z - 2 then
					his_hud = player:hud_add({
							hud_elem_type = "text",
							name = "defuser_timer",
							scale = {x = 1.5, y = 1.5},
							position = {x = 0.5, y = 0.5},
							offset = {x = 0, y = 20},
							size = {x = 2},
							alignment = {x = "center", y = "down"},
							--alignment = {x = 0, y = -1},
							text = "Defusing! do not drop your finger of the button!/n Secs: "..tostring(0),
							number = 0xCECECE,
						})
					for i = 1, 5 do
						number = tonumber(i + 0.70)
						core.after(number, function(playerr, o)
							playerr:hud_change(his_hud, "text", "Defusing! do not drop your finger of the button!/n Secs: "..tostring(i))
							if o == 5 then
								to_end = nil -- disable bomb explode on timer
								c4.planter = "none"
								c4.pos = {x=1,y=1,z=1}
								c4.planted = false
							end
						end, player, i)
					end
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
		end
	end,
	on_drop = function(itm, drp, pos)
		hud_events.new(drp, {
			text = "(!) Cant drop a defuser!",
			color = "warning",
			quick = true,
		})
	end,
	on_pickup = function(_, lname, table)
		clua.throw("core/defuser.lua: line 19: Defuser have been dropped, on pickup: <= on drop!")
	end,
})