if not bots then
	return
end
bots.register_bot("cs_bots_registering:crusher", {
	bot_name = "Crusher",
	rifles = {"rangedweapons:ak47"},
	pistols = {"rangedweapons:luger"},
	hp = 20,
	group = "terrorist",
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