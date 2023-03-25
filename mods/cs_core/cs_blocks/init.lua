minetest.register_node(":csgo:node", {
	description = ("Node\n Used to fill free space."),
	tiles = {"cs_blocks-node.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "glasslike_framed",
	sounds = default.node_sound_stone_defaults(),
}) -- Used to fill free space

minetest.register_node(":csgo:iglass", {
	description = "Indestructible Glass\n Used for the barrier by default",
	drawtype = "glasslike_framed",
	tiles = {"default_glass.png", "default_glass_detail.png"},
	inventory_image = minetest.inventorycube("default_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = true,
	buildable_to = false,
	pointable = true,
	groups = {immortal = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node(":csgo:trap", {
	description = "Player Killer\n Used when the player is caught flying in the wall\n Must be used to fill free unused space!",
	drawtype = "glasslike",
	tiles = {"invisible.png"},
	paramtype = "light",
	sunlight_propogates = true,
	walkable = false,
	pointable = true,
	damage_per_second = 20,
	is_ground_content = false,
	groups = {immortal = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node(":csgo:kill", {
	description = "Player Killer\n Used when the player is caught flying in the wall\n Must be used to fill free unused space!",
	drawtype = "glasslike",
	tiles = {"killnode.png"},
	paramtype = "light",
	sunlight_propogates = true,
	walkable = false,
	pointable = true,
	damage_per_second = 20,
	is_ground_content = false,
	groups = {immortal = 1},
	sounds = default.node_sound_glass_defaults(),
})