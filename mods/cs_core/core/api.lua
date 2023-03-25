cs_api = {}
--Logs the errors/things that the CSGO engine does... param= cs_core("warn/action/error/ferror", info)
function cs_core.log(act, message, over)
if act and message then

	core.debug(act, message, over)

end
end
--Huds
hud = mhud.init()
function cs_core.add_ammo_hud(amount, person)
hud:add(person, "amount", {
  hud_elem_type = "text",
  position = {x = 0.9, y = 0.85},
  offset = {x = 3, y = 50},
  alignment = {x = "right", y = "down"},
  text = amount,
  color = 0xebebeb,
})
end
function cs_core.mod_ammo_hud(amount, person)
hud:remove(person, "amount")
hud:add(person, "amount", {
  hud_elem_type = "text",
  position = {x = 0.9, y = 0.85},
  offset = {x = 3, y = 50},
  alignment = {x = "right", y = "down"},
  text = amount,
  color = 0xebebeb,
})
end
--API
function cs_core.can_do_damage(person, option)
	if (person) then
		if (option) then
			if (option == "no") then
			cs_api[person].damage = false
			cs_core.log("action", "Player {" .. person .. "} is set now has non-killer.")
			end
			if (option == "yes") then
			cs_api[person].damage = true
			cs_core.log("action", "Player {" .. person .. "} is set now has killer.")
			end
			
		end
	end
end

function cs_core.ask_can_do_damage(person)
if (cs_api[person].damage == false) then
return false
else
return true
end

end

--
minetest.register_on_joinplayer(function(player)
local name = player:get_player_name()
	cs_api[name] = {}
	
end)
--]]
minetest.register_on_dieplayer(function(player)
	local player_name = player:get_player_name()
	local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
	if (csgo.online[player] == true) then
	csgo.spectator(player_name, "Died, he's now a spectator")
	end
end)




--[[
cs_map_terrorist_place = cs_map.map_value_terrorist()
cs_map_counter_place = cs_map.map_value_counter()
--]]










































