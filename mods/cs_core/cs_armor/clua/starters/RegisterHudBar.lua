--[[hb.register_hudbar("armor", 0xFFFFFF, minetest.translator("hbarmor", "Armor"), {
	icon = "hbarmor_icon.png",
	bgicon = "hbarmor_bgicon.png",
	bar = "hbarmor_bar.png" },
	0,
	100,
	hbarmor.autohide,
	N("@1: @2%"),
	{ order = { "label", "value" },
	textdomain = "hbarmor" }
)--]]

--hb.register_hudbar("armor", 0xFFFFFF, "Armor", { bar = "cs_files_armor_bar.png", icon = "cs_files_armor_icon.png"}, 0, 100, false, ("@1: @2%"), { order = { "label", "value" }, textdomain = "armor" })

-- Deleted feature: auto-hide hud will dont be more available.
--[[
function armor.hide_hud(player)
	hb.hide_hudbar(player, "armor")
end
function armor.unhide_hud(player)
	hb.unhide_hudbar(player, "armor")
end--]]


