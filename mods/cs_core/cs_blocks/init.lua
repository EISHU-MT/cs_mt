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
		description = "Trap", 
		drawtype = "airlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable     = false,
		pointable    = false,
		diggable     = false,
		buildable_to = false,
		air_equivalent = true,
		damage_per_second = 40,
		tiles = {"blank.png"},
		groups = {immortal = 1},
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
minetest.register_node(":csgo:sign_a", {
	description = "(<= A) sign",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	tiles = { "cs_files_a1.png" },
	use_texture_alpha = true,
	walkable = false,
	groups = { immortal = 1 },
	sunlight_propagates = true,
})
minetest.register_node(":csgo:sign_b", {
	description = "(<= B) sign",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	tiles = { "cs_files_b1.png" },
	walkable = false,
	use_texture_alpha = true,
	groups = { immortal = 1 },
	sunlight_propagates = true,
})
minetest.register_node(":csgo:sign_a2", {
	description = "(A) sign",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	tiles = { "cs_files_a2.png" },
	walkable = false,
	groups = { immortal = 1 },
	use_texture_alpha = true,
	sunlight_propagates = true,
})
minetest.register_node(":csgo:sign_a3", {
	description = "(A) sign",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	tiles = { "cs_files_a3.png" },
	walkable = false,
	groups = { immortal = 1 },
	use_texture_alpha = true,
	sunlight_propagates = true,
})
minetest.register_node(":csgo:sign_b2", {
	description = "(B) sign",
	drawtype = "signlike",
	paramtype = "light",
	use_texture_alpha = true,
	paramtype2 = "wallmounted",
	tiles = { "cs_files_b2.png" },
	walkable = false,
	groups = { immortal = 1 },
	sunlight_propagates = true,
})
minetest.register_node(":csgo:sign_b3", {
	description = "(B) sign",
	drawtype = "signlike",
	paramtype = "light",
	use_texture_alpha = true,
	paramtype2 = "wallmounted",
	tiles = { "cs_files_b3.png" },
	walkable = false,
	groups = { immortal = 1 },
	sunlight_propagates = true,
})