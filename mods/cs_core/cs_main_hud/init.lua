-- BY EISHU
main_hud = {
	terrorist = {number = 0},
	counter = {number = 0},


}
--hud = mhud.init() -- Now this mod has been indenpendiced from mhud (Glory to Cs Main Hud!)


minetest.register_on_joinplayer(function(player)

terroristh = player:hud_add({ -- Terrorists hud
	hud_elem_type = "text",
	position = {x = 1, y = 0.05},
	offset = {x=-100, y = 20},
	scale = {x = 100, y = 100},
	text = "Terrorist: "..csgo.team.terrorist.count,
	number = 0xFFA900,
})

counterh = player:hud_add({
	hud_elem_type = "text",
	position = {x = 1, y = 0},
	offset = {x=-100, y = 20},
	scale = {x = 100, y = 100},
	text = "Counters: "..csgo.team.counter.count,
	number = 0x0081FF,
})

end)
--core.register

function update_frames()
	for __, name in pairs(core.get_connected_players()) do
	--player = core.get_player_by_name(name)
	
	name:hud_change(counterh, "text", "Counters: "..csgo.team.counter.count)
	name:hud_change(terroristh, "text", "Terrorist: "..csgo.team.terrorist.count)
	
	end
core.after(0.5, update_frames)
end
core.after(0.5, update_frames)



function main_hud.set_main_terrorist(number)
if number then
core.debug("red", "Using function main_hud.set_main_terrorist() is deprecated.", "CS:GO Main Hud")
end
end

function main_hud.set_main_counter(number)
if number then
	core.debug("red", "Using function main_hud.set_main_counter() is deprecated.", "CS:GO Main Hud")
end
end
