local S = minetest.get_translator("cs_shop")
do
cs_shop = {
	ammo_val = 30,
	arms = {
		arms_type_1 = {
			-- Rifles / Snipers
			"rangedweapons:m16",
			"rangedweapons:scar",
			"rangedweapons:ak47",
			"rangedweapons:g36",
			"rangedweapons:awp",
			"rangedweapons:svd",
			"rangedweapons:m200",
			-- Shotguns
			"rangedweapons:remington",
			"rangedweapons:spas12",
			"rangedweapons:benelli",
			"rangedweapons:jackhammer",
			"rangedweapons:aa12",
			--SMGs (1)
			"rangedweapons:kriss_sv",
		},
		arms_type_2 = {
			"rangedweapons:deagle",
			"rangedweapons:glock17",
			"rangedweapons:m1991",
			"rangedweapons:beretta",
			"rangedweapons:luger",
			"rangedweapons:makarov",
			--SMGs
			"rangedweapons:tmp",
			"rangedweapons:tec9",
			"rangedweapons:uzi",
		},
		arms_type_3 = {
			"grenades:frag",
			"grenades:flashbang",
			"grenades:smoke",
			"grenades:frag_sticky",
		},
		arms_type_4 = {
			"armor200",
			"armor100",
			"core:defuser",
		},
	},
	arms_values = {
		--Rifles
		["rangedweapons:m16"] =        160,
		["rangedweapons:scar"] =       220,
		["rangedweapons:svd"] =        220,
		["rangedweapons:ak47"] =       220,
		["rangedweapons:g36"] =        170,
		["rangedweapons:awp"] =        270,
		["rangedweapons:m200"] =       290,
		--Shotguns
		["rangedweapons:remington"] =  35,
		["rangedweapons:spas12"] =     45,
		["rangedweapons:benelli"] =    40,
		["rangedweapons:jackhammer"] = 90,
		["rangedweapons:aa12"] =       70,
		--SMGs
		["rangedweapons:kriss_sv"] =   50,
		["rangedweapons:tmp"] =        50,
		["rangedweapons:tec9"] =       50,
		["rangedweapons:uzi"] =        60,
		--Pistols
		["rangedweapons:deagle"] =     100,
		["rangedweapons:glock17"] =    60,
		["rangedweapons:luger"] =      58,
		["rangedweapons:m1991"] =      57,
		["rangedweapons:beretta"] =    57,
		["rangedweapons:makarov"] =    50,
		--Armors page
		["core:defuser"] =             70,
		["armor100"] =                 100,
		["armor200"] =                 200,
	},
	arms_ammo = {
		--Rifles
		rifle = {
			exe_amount                   = false,
			["rangedweapons:m16"] =        "rangedweapons:556mm 160",
			["rangedweapons:scar"] =       "rangedweapons:556mm 160",
			["rangedweapons:svd"] =        "rangedweapons:762mm 160",
			["rangedweapons:ak47"] =       "rangedweapons:762mm 160",
			["rangedweapons:g36"] =        "rangedweapons:556mm 160",
			["rangedweapons:awp"] =        "rangedweapons:762mm 160",
			["rangedweapons:m200"] =       "rangedweapons:408cheytac 50",
			["rangedweapons:kriss_sv"] =   "rangedweapons:9mm",
		},
		shotgun = {
			--Shotguns
			exe_amount =                   true,
			ammo_amount =                  50,
			["rangedweapons:remington"] =  "rangedweapons:shell",
			["rangedweapons:spas12"] =     "rangedweapons:shell",
			["rangedweapons:benelli"] =    "rangedweapons:shell",
			["rangedweapons:jackhammer"] = "rangedweapons:shell",
			["rangedweapons:aa12"] =       "rangedweapons:shell",
		},
				--SMGs
		smg = {
			exe_amount =                   true,
			ammo_amount =                  100,
			["rangedweapons:tmp"] =        "rangedweapons:9mm",
			["rangedweapons:tec9"] =       "rangedweapons:9mm",
			["rangedweapons:uzi"] =        "rangedweapons:9mm",
		},
		pistol = {
			--Pistols
			exe_amount =                   true,
			ammo_amount =                  60,
			["rangedweapons:deagle"] =     "rangedweapons:44",
			["rangedweapons:glock17"] =    "rangedweapons:9mm",
			["rangedweapons:luger"] =      "rangedweapons:9mm",
			["rangedweapons:m1991"] =      "rangedweapons:45acp",
			["rangedweapons:beretta"] =    "rangedweapons:9mm",
			["rangedweapons:makarov"] =    "rangedweapons:9mm",
		},
		--Armors page
		exe_amount =            false,
		["core:defuser"] =             70,
		["armor100"] =                 100,
		["armor200"] =                 200,
	},
	arms_types = {
		--Rifle
		["rangedweapons:m16"] =        "rifle",
		["rangedweapons:scar"] =       "rifle",
		["rangedweapons:svd"] =        "rifle",
		["rangedweapons:ak47"] =       "rifle",
		["rangedweapons:g36"] =        "rifle",
		["rangedweapons:awp"] =        "rifle",
		["rangedweapons:m200"] =       "rifle",
		--Shotguns
		["rangedweapons:remington"] =  "shotgun",
		["rangedweapons:spas12"] =     "shotgun",
		["rangedweapons:benelli"] =    "shotgun",
		["rangedweapons:jackhammer"] = "shotgun",
		["rangedweapons:aa12"] =       "shotgun",
		--SMGs
		["rangedweapons:kriss_sv"] =   "smg",
		["rangedweapons:tmp"] =        "smg",
		["rangedweapons:tec9"] =       "smg",
		["rangedweapons:uzi"] =        "smg",
		--Pistols
		["rangedweapons:deagle"] =     "pistol",
		["rangedweapons:glock17"] =    "pistol",
		["rangedweapons:luger"] =      "pistol",
		["rangedweapons:m1991"] =      "pistol",
		["rangedweapons:beretta"] =    "pistol",
		["rangedweapons:makarov"] =    "pistol",
		--Armors page
		["core:defuser"] =             "special",
		["armor100"] =                 "special",
		["armor200"] =                 "special",
	},
	transactions = {},
	grenades = {
		flashbang = {},
		frag = {},
		smoke = {},
		frag_sticky = {},
	},
	grenades_values = {
		["grenades:frag"] =        100,
		["grenades:flashbang"] =   70,
		["grenades:smoke"] =       80,
		["grenades:frag_sticky"] = 130,
	},
	grenades_amounts = {
		["grenades:frag"] =        1,
		["grenades:flashbang"] =   2,
		["grenades:smoke"] =       1,
		["grenades:frag_sticky"] = 1,
	},
	ammo_values = {
		["10mm"] = 50,
		["308winchester"] = 50,
		["357"] = 50,
		["408cheytac"] = 50,
		["40mm"] = 50,
		["44"] = 50,
		["45acp"] = 50,
		["556mm"] = 50,
		["762mm"] = 50,
		["9mm"]   = 50,
		["shell"] = 50,
		["50ae"]  = 50,
	},
	ammo_drops = {
		["10mm"] = 50,
		["308winchester"] = 50,
		["357"] = 45,
		["408cheytac"] = 18,
		["40mm"] = 5,
		["44"] = 45,
		["45acp"] = 85,
		["556mm"] = 75,
		["762mm"] = 70,
		["9mm"]   = 100,
		["shell"] = 25,
		["50ae"]  = 45,
	}
}
end

local modpath = core.get_modpath(minetest.get_current_modname())
dofile(modpath.."/arms/formspecs.lua")
dofile(modpath.."/arms/grenades.lua")
dofile(modpath.."/arms/rifles.lua")
dofile(modpath.."/arms/pistol_smg.lua")
dofile(modpath.."/arms/armor.lua")
dofile(modpath.."/arms/shotgun.lua")

function RecognizeArm(arm)
	if arm and type(arm) == "string" then
		for a, i in pairs(cs_shop.arms.arms_type_1) do
			if i == arm then
				return true, "hard_arm"
			end
		end
		for a, i in pairs(cs_shop.arms.arms_type_2) do
			if i == arm then
				return true, "soft_arm"
			end
		end
		for a, i in pairs(cs_shop.arms.arms_type_3) do
			if i == arm then
				return true, "grenade", arm
			end
		end
		if arm == "bomb" then -- Recognize the c4 bomb
			return true, "c4_bomb"
		end
		return false, "non_existent"
	end
end

function IsGrenade(grt)
	assert(grt, "No grenade name found!")
	for _, gr in pairs(cs_shop.arms.arms_type_3) do
		if grt == gr then
			return true
		end
	end
	return false
end

function SendOnBuy(p, m, a)
	core.chat_send_player(clua.pname(p), core.colorize("#A67979", "-$"..tostring(a)).." "..core.colorize("#FF9D00", "On Buying "..tostring(m)))
end

function SendOnFail(p, a)
	core.chat_send_player(clua.pname(p), core.colorize("#A67979", "Failed On Buy: "..tostring(a)..", No money?"))
end

function RecognizeType(arm)
	return cs_shop.arms_types[arm] or false
end

cs_shop.recognize_arm = RecognizeArm

inventory = {} -- no more errors / get item from other user
to_check = {}
get_named = {}
money_value = {}
his_money = {}
pnamee = {}

function RecognizeType(arm)
	return cs_shop.arms_types[arm] or false
end

function cs_shop.buy_ammo(ammo, p)
	assert(ammo, "No ammo presense found")
	assert(type(p) ~= "userdata", "Player UserData not found or a string....")
	local pname = p:get_player_name()
	if cs_shop.ammo_values[ammo] then
		his_money[pname] = bank.return_val(pname)
		if (his_money >= cs_shop.ammo_values[ammo]) then
			inventory[pname] = p:get_inventory()
			local amount = cs_shop.ammo_drops[ammo] or 80
			inventory[pname]:add_item("main", ItemStack("rangedweapons:"..ammo.." "..tostring(amount)))
			SendOnBuy(p, ammo, amount)
		else
			SendOnFail(p, t)
		end
	end
end

function cs_shop.buy_grenade(gr, p, t)
	local pname = clua.pname(p)
	his_money[pname] = bank.return_val(pname) or 0
	if IsGrenade(gr) and p then
		if (his_money[pname] >= cs_shop.grenades_values[gr]) then
			if cs_shop.grenades[t][pname] ~= cs_shop.grenades_amounts[gr] then
				inventory[pname] = p:get_inventory()
				inventory[pname]:add_item("main", ItemStack(gr))
				cs_shop.grenades[t][pname] = cs_shop.grenades[t][pname] + 1
				SendOnBuy(p, t, his_money[pname])
			end
		else
			SendOnFail(p, t)
		end
		his_money[pname] = nil
		inventory[pname] = nil
	end
end

function cs_shop.buy_arm(arm, p)
	local pname = clua.pname(p)
	local player = clua.player(p)
	inventory[pname] = player:get_inventory()
	if type(arm) == "string" then
		get_named[pname] = RecognizeType(arm)
		
		if get_named[pname] == "rifle" or get_named[pname] == "shotgun" then
			to_check[pname] = "arms_type_1"
		elseif get_named[pname] == "pistol" or get_named[pname] == "smg" then
			to_check[pname] = "arms_type_2"
		end
		
		for _, typed in pairs(player:get_inventory():get_list("main")) do
			local name = typed:get_name()
			for i, str in pairs(cs_shop.arms[to_check[pname]]) do
				if str == name then
					local stack = ItemStack(str)
					inventory[pname]:remove_item("main", stack)
					minetest.item_drop(typed, player, player:get_pos())
					
					
					local a1 = RecognizeType(str)
					local ammo = cs_shop.arms_ammo[a1][str]
					if cs_shop.arms_ammo[a1].exe_amount then
						local amount = cs_shop.arms_ammo[a1].ammo_amount
						local stack = ItemStack(tostring(cs_shop.arms_ammo[a1][str])..tostring(amount))
						inventory[pname]:remove_item("main", stack)
						minetest.item_drop(stack, player, player:get_pos())
					else
						local stack = ItemStack(tostring(cs_shop.arms_ammo[a1][str]))
						inventory[pname]:remove_item("main", stack)
						minetest.item_drop(stack, player, player:get_pos())
					end
					
					
					--minetest.item_drop(stack, player, player:get_pos())
				end
			end
		end
		money_value[pname] = tonumber(cs_shop.arms_values[arm])
		his_money[pname] = bank.return_val(pname)
		if his_money[pname] >= (money_value[pname] + cs_shop.ammo_val) then
			inventory[pname]:add_item("main", ItemStack(arm))
			if cs_shop.arms_ammo[RecognizeType(arm)].exe_amount then
				v = cs_shop.arms_ammo[RecognizeType(arm)].ammo_amount
			end
			if v then
				inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(arm)][arm]..v))
			else
				inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(arm)][arm]))
			end
			SendOnBuy(p, ItemStack(arm):get_short_description(), cs_shop.arms_values[arm])
		else
			SendOnFail(p, t)
		end
	end
	-- Clean cache!
	his_money[pname] = nil
	money_value[pname] = nil
	inventory[pname] = nil
	to_check[pname] = nil
	get_named[pname] = nil
end

-- Fields
minetest.register_on_player_receive_fields(function(player, formname, field)
	if formname ~= "" then
		 return
	end
	if field.rifle or field.sniper then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:rifle", cs_shop.rifle(name))
	end
	if field.ammo then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:ammo", cs_shop.ammo(name))
	end
	if field.grenade then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:grenade", cs_shop.grenade(name))
	end
	if field.pistol then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:pistol", cs_shop.pistol(name))
	end
	if field.armor then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:armor", cs_shop.armor(name))
	end
	if field.shotguns then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
	if field.smg then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:smg", cs_shop.smg(name))
	end
	if field.exit then
		local name = player:get_player_name()
		minetest.disconnect_player(name, "Disconnected from gui (CsShop MSG)")
	end
end)


do
	if not clua.get_bool("map_edit", clua.get_table_value("central_csgo")) then
		function cs_shop.enable_shopping(player)
			if player then
			player:set_inventory_formspec(cs_shop.main(player))
			else
				for _, player in pairs(core.get_connected_players()) do
				--local playerr = core.get_player_by_name(player)
				player:set_inventory_formspec(cs_shop.main(player))
				end
			end
		end
		function cs_shop.disable_shopping(player)
			if player then
			player:set_inventory_formspec(cs_shop.fmain(player))
			else
				for _, player in pairs(core.get_connected_players()) do
				--local playerr = core.get_player_by_name(player)
				player:set_inventory_formspec(cs_shop.fmain(player))
				end
			end
		end
	elseif clua.get_bool("map_edit", clua.get_table_value("central_csgo")) then
		function cs_shop.disable_shopping() end
		function cs_shop.enable_shopping() end
	end
end

-- time to link
do
	cs_buying = cs_shop
end

minetest.register_on_joinplayer(function(player)
	local p=player:get_player_name()
	cs_shop.grenades.frag[p] = 0
	cs_shop.grenades.flashbang[p] = 0
	cs_shop.grenades.smoke[p] = 0
	cs_shop.grenades.frag_sticky[p] = 0
end)



