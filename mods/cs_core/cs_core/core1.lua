-- This is the primary core of CS:GO.
-- The secondary core is cs_register
--[
minetest.register_node(":core:air", {
	description = "Air. just dont breath it!",
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
if not minetest.settings:get_bool("cs_map.mapmaking", false) then
	minetest.register_node(":cs_core:terrorists", {
		description = "Terrorist node",
		drawtype = "airlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		floodable = true,
		air_equivalent = true,
		drop = "",
		groups = {not_in_creative_inventory=1},
	})
	minetest.register_node(":cs_core:counters", {
		description = "Counter node.",
		drawtype = "airlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		floodable = true,
		air_equivalent = true,
		drop = "",
		groups = {not_in_creative_inventory=1},
	})
end
cs_core = {}
local modpath = core.get_modpath(minetest.get_current_modname())

minetest.register_on_joinplayer(function(player)
	player:set_nametag_attributes({ -- Disable nametag
		text = " ",
		--color = false,
		bgcolor = 0x00000,
	})
	AddPrivs(player, {fly=nil, fast=nil, noclip=nil, teleport=nil, interact=true, shout=true})
	player:get_inventory():set_list("main", {})
	end)

minetest.after(0.1, function()
	core.log("action", "Starting Maps/Env")
	minetest.clear_objects({ mode = "quick" })
	cs_match.register_matches(15)
	cs_match.start_matches()
end)



function get_status() return nil end


core.register_privilege("core", {
	description = "Can manage CS:GO Like mods",
	give_to_singleplayer = false,
	give_to_admin = true,
})


















