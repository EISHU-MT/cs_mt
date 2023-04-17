-- CS Hud of items, replacing the items bar
-- Main table
cih = {
	-- Huds tables
	rifle_hud = {},
	pistol_hud = {},
	-- Subtables
	bombs_hud = {
		fb = {}, -- FlashBang
		gr = {}, -- Normal Grenade
		sg = {}, -- Smoke grenade
		sf = {}, -- Sticky Frag
	},
	c4 = {},
	-- RifleHudData
	rhd = {},
	-- PistolHudData
	phd = {},
	-- BombHudData (Contains HudTables)
	bhd = {
		fb = {}, -- FlashBang
		gr = {}, -- Normal Grenade
		sg = {}, -- Smoke grenade
		sf = {}, -- Sticky Frag
	},
	c4d = {},
}
disabled_hud = {}
-- 
minetest.register_on_joinplayer(function(player)

	--Playername
	pname = player:get_player_name()

	disabled_hud[pname] = false

	cih.pistol_hud[pname] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.97, y = 0.6},
		offset = {x=-100, y = 20},
		scale = {x=3, y=3},
		text = "invisible.png",
		--z_index = -200,
	})
	cih.c4[pname] = player:hud_add({ -- not shown at counters
		hud_elem_type = "image",
		position = {x = 0.97, y = 0.5},
		offset = {x=-100, y = 20},
		scale = {x=3, y=3},
		text = "invisible.png",
		--z_index = -200,
	})
	cih.rifle_hud[pname] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.97, y = 0.7},
		offset = {x=-100, y = 20},
		scale = {x=3, y=3},
		text = "invisible.png",
		--z_index = -200,
	})
	cih.bombs_hud.fb[pname] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 1, y = 0.83},
		offset = {x=-100, y = 20},
		scale = {x=3, y=3},
		text = "grenades_flashbang.png",
		--z_index = -200,
	})
	cih.bombs_hud.gr[pname] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.97, y = 0.83},
		offset = {x=-100, y = 20},
		scale = {x=3, y=3},
		text = "grenades_frag.png",
		--z_index = -200,
	})
	cih.bombs_hud.sg[pname] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.94, y = 0.83},
		offset = {x=-100, y = 20},
		scale = {x=3, y=3},
		text = "grenades_smoke_grenade.png",
		--z_index = -200,
	})
	cih.bombs_hud.sf[pname] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.91, y = 0.83},
		offset = {x=-100, y = 20},
		scale = {x=3, y=3},
		text = "grenades_frag_sticky.png",
		--z_index = -200,
	})

--- Now the number where that is it!

	--C4
	cih.c4d[pname] = player:hud_add({
			hud_elem_type = "text",
			position = {x = 1.03, y = 0.5},
			offset = {x=-100, y = 20},
			scale = {x = 100, y = 100},
			text = " ",
			--z_index = -200,
		})

	--Pistol Hud Number
	cih.phd[pname] = player:hud_add({
			hud_elem_type = "text",
			position = {x = 1.03, y = 0.6},
			offset = {x=-100, y = 20},
			scale = {x = 100, y = 100},
			text = "-",
			--z_index = -200,
		})
	--Rifle Hud Number
	cih.rhd[pname] = player:hud_add({
		hud_elem_type = "text",
		position = {x = 1.03, y = 0.7},
		offset = {x=-100, y = 20},
		scale = {x = 100, y = 100},
		text = "-",
		--z_index = -200,
	})
	-- Grenades
	cih.bhd.fb[pname] = player:hud_add({
		hud_elem_type = "text",
		position = {x = 1,    y = 0.89},
		offset = {x=-100, y = 20},
		scale = {x = 100, y = 100},
		text = "-",
		--z_index = -200,
	})
	cih.bhd.gr[pname] = player:hud_add({
		hud_elem_type = "text",
		position = {x = 0.97, y = 0.89},
		offset = {x=-100, y = 20},
		scale = {x = 100, y = 100},
		text = "-",
		--z_index = -200,
	})
	cih.bhd.sg[pname] = player:hud_add({
		hud_elem_type = "text",
		position = {x = 0.94, y = 0.89},
		offset = {x=-100, y = 20},
		scale = {x = 100, y = 100},
		text = "-",
		--z_index = -200,
	})
	cih.bhd.sf[pname] = player:hud_add({
		hud_elem_type = "text",
		position = {x = 0.91, y = 0.89},
		offset = {x=-100, y = 20},
		scale = {x = 100, y = 100},
		text = "-",
		--z_index = -200,
	})

-- His hud options
	player:hud_set_flags({
		hotbar = false,
	})
	
	if_on_had[pname] = {hard_arm = "", soft_arm = "", c4_bomb = "", grenades = {frag = "", flashbang = "", frag_sticky = "", smoke = ""}}

end)
do
	if_on_had = {}
end
--[brighten
local function on_step()
	for a, e in pairs(core.get_connected_players()) do
		if not disabled_hud[e:get_player_name()] then
			local pname = e:get_player_name()
			local inv = e:get_inventory()
			local list = inv:get_list("main")
			for i, o in pairs(list) do
				local u = o:get_name()
				local b, str, str2 = RecognizeArm(u) -- str2 is used only in grenades
				if b == true and str then
					if str == "hard_arm" then
						e:hud_change(cih.rhd[pname], "text", tostring(i))
						local image = o:get_definition().inventory_image
						e:hud_change(cih.rifle_hud[pname], "text", image)
						if_on_had[pname].hard_arm = u
					elseif str == "soft_arm" then
						e:hud_change(cih.phd[pname], "text", tostring(i))
						local image = o:get_definition().inventory_image
						e:hud_change(cih.pistol_hud[pname], "text", image)
						if_on_had[pname].soft_arm = u
					elseif str == "grenade" and str2 then
						if str2 == "grenades:frag" then
							e:hud_change(cih.bhd.gr[pname], "text", tostring(i))
							e:hud_change(cih.bombs_hud.gr[pname], "text", "grenades_frag.png")
							if_on_had[pname].grenades.frag = "grenades:frag"
						end
						if str2 == "grenades:smoke" then
							e:hud_change(cih.bhd.sg[pname], "text", tostring(i))
							e:hud_change(cih.bombs_hud.gr[pname], "text", "grenades_smoke_grenade.png")
							if_on_had[pname].grenades.smoke = "grenades:smoke"
						end
						if str2 == "grenades:flashbang" then
							e:hud_change(cih.bhd.fb[pname], "text", tostring(i))
							e:hud_change(cih.bombs_hud.fb[pname], "text", "grenades_flashbang.png")
							if_on_had[pname].grenades.flashbang = "grenades:flashbang"
						end
						if str2 == "grenades:frag_sticky" then
							e:hud_change(cih.bhd.sf[pname], "text", tostring(i))
							e:hud_change(cih.bombs_hud.sf[pname], "text", "grenades_frag_sticky.png")
							if_on_had[pname].grenades.frag_sticky = "grenades:frag_sticky"
						end
					elseif str == "c4_bomb" then
						e:hud_change(cih.c4d[pname], "text", tostring(i))
						e:hud_change(cih.c4[pname], "text", "cs_files_c4.png")
						if_on_had[pname].grenades.c4_bomb = true
					end
					-- Now check if rifle dont exists anymore...
					
					local tmp6
					tmp6 = e:hud_get(cih.rhd[pname])
					if tmp6.text ~= "-" and (not inv:contains_item("main", ItemStack(if_on_had[pname].hard_arm))) then
						e:hud_change(cih.rhd[pname], "text", "-")
						--local image = o:get_definition().inventory_image
						e:hud_change(cih.rifle_hud[pname], "text", "invisible.png")
						if_on_had[pname].hard_arm = ""
					end
					tmp6 = e:hud_get(cih.phd[pname])
					if tmp6.text ~= "-" and (not inv:contains_item("main", ItemStack(if_on_had[pname].soft_arm))) then
						e:hud_change(cih.phd[pname], "text", "-")
						--local image = o:get_definition().inventory_image
						e:hud_change(cih.pistol_hud[pname], "text", "invisible.png")
						if_on_had[pname].hard_arm = ""
					end
					tmp6 = e:hud_get(cih.bhd.gr[pname])
					if tmp6.text ~= "-" and (not inv:contains_item("main", ItemStack(if_on_had[pname].grenades.frag))) then
						e:hud_change(cih.bhd.gr[pname], "text", "-")
						e:hud_change(cih.bombs_hud.gr[pname], "text", "grenades_frag.png")
						if_on_had[pname].grenades.frag = ""
					end
					tmp6 = e:hud_get(cih.bhd.sg[pname])
					if tmp6.text ~= "-" and (not inv:contains_item("main", ItemStack(if_on_had[pname].grenades.smoke))) then
						e:hud_change(cih.bhd.sg[pname], "text", "-")
						e:hud_change(cih.bombs_hud.sg[pname], "text", "grenades_smoke_grenade.png")
						if_on_had[pname].grenades.smoke = ""
					end
					tmp6 = e:hud_get(cih.bhd.fb[pname])
					if tmp6.text ~= "-" and (not inv:contains_item("main", ItemStack(if_on_had[pname].grenades.flashbang))) then
						e:hud_change(cih.bhd.fb[pname], "text", "-")
						e:hud_change(cih.bombs_hud.fb[pname], "text", "grenades_flashbang.png")
						if_on_had[pname].grenades.flashbang = ""
					end
					tmp6 = e:hud_get(cih.bhd.sg[pname])
					if tmp6.text ~= "-" and (not inv:contains_item("main", ItemStack(if_on_had[pname].grenades.frag_sticky))) then
						e:hud_change(cih.bhd.sf[pname], "text", "-")
						e:hud_change(cih.bombs_hud.sf[pname], "text", "grenades_frag_sticky.png")
						if_on_had[pname].grenades.frag_sticky = ""
					end
					tmp6 = e:hud_get(cih.c4d[pname])
					if tmp6.text ~= "-" and (not inv:contains_item("main", ItemStack("bomb"))) then
						e:hud_change(cih.c4d[pname], "text", tostring(i))
						e:hud_change(cih.c4[pname], "text", "cs_files_c4.png")
					end
				end
				
			end
		end
	end
end

core.register_globalstep(on_step)


function disable_hud(player)
	disabled_hud[player:get_player_name()] = true
	local pname = player:get_player_name()
	e = player
	-- Grenades
	e:hud_change(cih.bhd.gr[pname], "text", " ")
	e:hud_change(cih.bombs_hud.gr[pname], "text", "invisible.png")
	e:hud_change(cih.bhd.sg[pname], "text", " ")
	e:hud_change(cih.bombs_hud.sg[pname], "text", "invisible.png")
	e:hud_change(cih.bhd.fb[pname], "text", " ")
	e:hud_change(cih.bombs_hud.fb[pname], "text", "invisible.png")
	e:hud_change(cih.bhd.sf[pname], "text", " ")
	e:hud_change(cih.bombs_hud.sf[pname], "text", "invisible.png")
	-- Rifles / Others
	e:hud_change(cih.rhd[pname], "text", " ")
	e:hud_change(cih.rifle_hud[pname], "text", "invisible.png")
	e:hud_change(cih.phd[pname], "text", " ")
	e:hud_change(cih.pistol_hud[pname], "text", "invisible.png")
	-- C4
	e:hud_change(cih.c4d[pname], "text", " ")
	e:hud_change(cih.c4[pname], "text", "invisible.png")
end




core.register_chatcommand("helper_hud", {
	description = "Enables/Disables helper hud",
	params = "<No params!>",
	func = function(name)
		if disabled_hud[clua.pname(name)] == false then
			clua.player(name):hud_set_flags({
				hotbar = true,
			})
			disable_hud(clua.player(name))
			return "-!- Disabled: Desktop Helper Hud"
		elseif disabled_hud[clua.pname(name)] == true then
			clua.player(name):hud_set_flags({
				hotbar = false,
			})
			disabled_hud[clua.pname(name)] = false
			return "-!- Enabled: Desktop Helper Hud"
		end
	end,
})














