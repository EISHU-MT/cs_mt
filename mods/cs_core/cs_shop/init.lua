local S = minetest.get_translator("cs_buying")
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
		rifles = {
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
		shotguns = {
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
		smgs = {
			exe_amount =                   true,
			ammo_amount =                  100,
			["rangedweapons:tmp"] =        "rangedweapons:9mm",
			["rangedweapons:tec9"] =       "rangedweapons:9mm",
			["rangedweapons:uzi"] =        "rangedweapons:9mm",
		},
		pistols = {
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
	transactions = {}
}

function RecognizeArm(arm)
	if arm and type(arm) == "string" then
		for a, i in pairs(arms.arms_type_1) do
			if i == arm then
				return true, "hard_arm"
			end
		end
		for a, i in pairs(arms.arms_type_2) do
			if i == arm then
				return true, "soft_arm"
			end
		end
		for a, i in pairs(arms.arms_type_3) do
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

function RecognizeType(arm)
	return cs_shop.arms_types[arm] or false
end

cs_shop.recognize_arm = RecognizeArm

inventory = {} -- no more errors / get item from other user
to_check = {}
get_named = {}
money_value = {}
his_money = {}

function cs_shop.buy_arm(arm, p)
	local pname = clua.pname(p)
	local player = clua.player(p)
	inventory[pname] = player:get_inventory()
	if type(arm) == "string" then
		get_named[pname] = RecognizeType(arm)
		
		if get_named[pname] == "rifle" or get_named[pname] == "shotgun" then
			to_check[pname] = "arms_type_1"
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
					
					
					minetest.item_drop(typed2, player, player:get_pos())
				end
			end
		end
		money_value[pname] = tonumber(cs_shop.arms_values[arm])
		his_money[pname] = bank.return_val(pname)
		if his_money >= (money_value[pname] + cs_shop.ammo_val) then
			inventory[pname]:add_item("main", ItemStack(arm))
			if cs_shop.arms_ammo[RecognizeType(str)].exe_amount then
				v = cs_shop.arms_ammo[RecognizeType(str)].ammo_amount
			end
			if v then
				inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(str)][str]..v))
			else
				inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(str)][str]))
			end
		end
	end
end













