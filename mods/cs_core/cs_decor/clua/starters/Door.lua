doors.register("door_auto", {
		tiles = {"cs_files_door.png"},
		description = ("Automatic door"),
		inventory_image = "cs_files_door_inv.png",
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		gain_open = 0.2,
		gain_close = 0.2,
})