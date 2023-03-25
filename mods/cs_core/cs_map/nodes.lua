-- Special nodes
do
	minetest.register_node("cs_map:ign", {
		description = "CORE=Ignore Node.", 
		drawtype = "airlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable     = true,
		pointable    = false,
		diggable     = false,
		buildable_to = false,
		air_equivalent = true,


		groups = {immortal = 1},
	})
	minetest.register_node("cs_map:stone", {
		description = "Wall Stone\n ONLY USE IN BARRIERS", 
		tiles = {"bound.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable     = true,
		pointable    = true,
		diggable     = false,
		buildable_to = false,
		air_equivalent = true,

		groups = {immortal = 1},
	})
	minetest.register_node("cs_map:ind_glass", {
		description = "Wall Glass\n ONLY USE IN BARRIERS\n ", 
		tiles = {"wall.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable     = true,
		pointable    = true,
		diggable     = false,
		buildable_to = false,
		air_equivalent = true,
		groups = {immortal = 1},
	})

end

