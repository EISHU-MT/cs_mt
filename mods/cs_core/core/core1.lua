-- This is the primary core of CS:GO.
-- The secondary core is cs_register
--[
minetest.register_node(":core:air", {
	description = "Hmmmmm :)\n Dont Use this node in maps! its only for bounds\n why you had this node\n PUT ME INTO A TRASH QUICK!\n DO NOT USE /giveme core:air!!!!!\n nooo you are the most danger hackers :(",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = false,
	diggable = false,
	buildable_to = true,
	floodable = true,
	air_equivalent = true,
	drop = "",
	groups = {not_in_creative_inventory=1},
})
--]]
local map_edit = clua.get_bool("map_edit", clua.get_table_value("central_csgo"))
if not map_edit then
minetest.register_node(":cs_core:terrorists", {
	description = "node\n Used for Terrorists Spawn.",
	drawtype="nodebox",
	paramtype = "light",
	pointable = false,
	walkable = false,
	tiles = {
		"invisible.png",
	},
	groups = {oddly_breakable_by_hand=1,snappy=3},
})
minetest.register_node(":cs_core:counters", {
	description = "node\n Used for Counters Spawn.",
	drawtype="nodebox",
	paramtype = "light",
	walkable = false,
	pointable = false,
	tiles = {
		"invisible.png",
	},
	groups = {oddly_breakable_by_hand=1,snappy=3},
})
--[[
minetest.register_alias("cs_core:terrorist", "air")
minetest.register_alias("cs_core:counter", "air")
--]]
end
cs_core = {}


sum = 0
local modpath = core.get_modpath(minetest.get_current_modname())
-- Make main variable for use.

--[[
for cs_coret, def in pairs(cs_core.var) do -- Insert
	cs_core.var[cs_coret] = {count = 0, counter = 0, terrorist = 0}
	table.insert(cs_core.null, team) -- Null.
end
--]]



function remove_hoi()
for _, player in pairs(core.get_connected_players()) do
if player and hud:exists(player, "temp000x2") then
hud:remove(player, "temp000x2")

end
end
end

minetest.register_on_newplayer(function(player)

aplayer = player:get_player_name()
core.after(2, function()
core.chat_send_player(aplayer, "[SYS] Hiii!!\n Welcome to CS:GO Like!\n tip 1: To buy some items press inventory, remember inventory expires")
end)

end)

minetest.register_on_joinplayer(function(player)

player:set_nametag_attributes({ -- Disable nametag
	text = " ",
	--color = false,
	bgcolor = 0x00000,
})

if csgo.ask("frosen") then -- By EI
player:set_physics_override({
  --gravity = 1090
  speed = 0
})
end




local hud = mhud.init()
local playern = player:get_player_name()
minetest.set_player_privs(playern, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
hud:add(player, "screen", {
		hud_elem_type = "image",
		position = {x = 0.5, y = 0.5},
		image_scale = -100,
		texture = "screen.png"
})
for _, player in pairs(core.get_connected_players()) do
if player and hud:exists(player, "timerrrr") then

function TEMP_151()
hud:remove(player, "timerrrr")
end

core.after(1, TEMP_151)

end
end
player:get_inventory():set_list("main", {})
end)



cs_death = {
	team = {
		counter = {pos=false},
		terrorist = {pos=false},
		spectator = {pos=false},
	},


}

function cs_death.register_spawn(team, position)
		
		
		if team == "spectator" then
		cs_death.team.spectator.pos = position -- Enable variable
		end
		
		if team == "terrorist" then
		cs_death.team.terrorist.pos = position -- Enable variable
		end
		
		if team == "counter" then
		cs_death.team.counter.pos = position -- Enable variable
		end
		
		if team == "all" then
		cs_death.team.counter.pos = position -- Enable variable
		cs_death.team.terrorist.pos = position -- Enable variable
		cs_death.team.spectator.pos = position -- Enable variable
		end
		
end

--[[
minetest.register_chatcommand("gamee", {
    func = function(name)
	cs_core.log("action", "Starting Maps/Env")
	minetest.clear_objects({ mode = "quick" })
	cs_map.new_match()
	cs_death.register_spawn("all", spectators_spawn()) -- ALL: terrorists and counters, spectators_spawn(): where the spectators spawn
        
    end,
})
--]]




function cs_core.new_match()
cs_core.log("action", "Starting Maps/Env")
minetest.clear_objects({ mode = "quick" })
--[[
cs_death.register_spawn("terrorist", terrorists_spawn()) -- Only this is enabled when the mode is other
cs_death.register_spawn("counter", counters_spawn())
--]]
cs_match.register_matches(15) -- Number of matches, default 15
cs_match.start_matches()
--[[
function temp0x8432()

for _, player in pairs(core.get_connected_players()) do
		if player then
			playeree = player:get_player_name()
			core.chat_send_player(playeree, "New Match. Remember there are " .. cs_match.available_matches .. " rounds")
			hud:add(player, "temp000x2", {
			hud_elem_type = "text",
			--texture = "",
			scale = {x = 1.5, y = 1.5},
			position = {x = 0.800, y = 0.10},
			offset = {x = 30, y = 100},
			size = {x = 1.5},
			alignment = {x = 0, y = -1},
			text = "Be Fast!! shop your arms before time reach!\n You Had 20 Seconds to shop.",
			color = 0xFF9D00,
			})
			--[[
		if hud:exists(player, "temp000x2") then
		hud:remove(player, "temp000x2")
		end
		
		
		end
end
end
core.after(15, temp0x8432)
--]]



--cs_match.start_match()


yeettt = true
end

minetest.after(0.1, cs_core.new_match)
function get_status()
if yeettt then
return true
else
return nil
end
end


core.register_privilege("core", {
	description = "Can manage CS:GO Like mods",
	give_to_singleplayer = false,
	give_to_admin = true,
})


















