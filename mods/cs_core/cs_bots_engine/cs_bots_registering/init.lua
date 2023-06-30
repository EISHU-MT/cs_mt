if not bots then
	return
end
bots.register_bot("cs_bots_registering:crusher", {
	bot_name = "Crusher",
	rifles = {"rangedweapons:ak47", "rangedweapons:awp"},
	pistols = {"rangedweapons:luger", "rangedweapons:deagle"},
	hp = 20,
	team = "terrorist",
	model = "character.b3d",
	textures = {"red.1.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})

bots.register_bot("cs_bots_registering:eugene", {
	bot_name = "Eugene",
	rifles = {"rangedweapons:awp", "rangedweapons:ak47"},
	pistols = {"rangedweapons:deagle", "rangedweapons:deagle"},
	hp = 20,
	team = "counter",
	model = "character.b3d",
	textures = {"blue.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})

bots.register_bot("cs_bots_registering:karl", {
	bot_name = "Karl",
	rifles = {"rangedweapons:awp", "rangedweapons:m200"},
	pistols = {"rangedweapons:glock17", "rangedweapons:deagle"},
	hp = 20,
	team = "terrorist",
	model = "character.b3d",
	textures = {"red.2.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})

bots.register_bot("cs_bots_registering:slasher", {
	bot_name = "Slasher",
	rifles = {"rangedweapons:awp", "rangedweapons:m200"},
	pistols = {"rangedweapons:beretta", "rangedweapons:deagle"},
	hp = 20,
	team = "counter",
	model = "character.b3d",
	textures = {"blue.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})

bots.register_bot("cs_bots_registering:jose", {
	bot_name = "Jose",
	rifles = {"rangedweapons:ak47", "rangedweapons:awp"},
	pistols = {"rangedweapons:makarov", "rangedweapons:deagle"},
	hp = 20,
	team = "counter",
	model = "character.b3d",
	textures = {"blue.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})

bots.register_bot("cs_bots_registering:schweepes", {
	bot_name = "Schweepes",
	rifles = {"rangedweapons:spas12", "rangedweapons:jackhammer"},
	pistols = {"rangedweapons:beretta", "rangedweapons:deagle"},
	hp = 20,
	team = "terrorist",
	model = "character.b3d",
	textures = {"red.2.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})

bots.register_bot("cs_bots_registering:kriller", {
	bot_name = "Kriller",
	rifles = {"rangedweapons:ak47", "rangedweapons:awp"},
	pistols = {"rangedweapons:beretta", "rangedweapons:deagle"},
	hp = 20,
	team = "terrorist",
	model = "character.b3d",
	textures = {"red.2.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})

bots.register_bot("cs_bots_registering:tiago", {
	bot_name = "Tiago",
	rifles = {"rangedweapons:ak47", "rangedweapons:awp"},
	pistols = {"rangedweapons:beretta", "rangedweapons:deagle"},
	hp = 20,
	team = "counter",
	model = "character.b3d",
	textures = {"blue.png"},
	recharge = true,
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	sh = 0.6,
}, { -- Animations
	stand = {x = 0, y = 79},
	lay = {x = 162, y = 166},
	walk = {x = 168, y = 187},
	mine = {x = 189, y = 198},
	wmine = {x = 200, y = 219},
	sit = {x = 81, y = 160},
})