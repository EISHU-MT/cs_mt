local S = minetest.get_translator("cs_shop")
do
enabled_to = {}
disabled_to = {}
cs_shop = {
	queued = {},
	time = 0,
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
			--["rangedweapons:kriss_sv"] =   "rangedweapons:9mm",
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
			["rangedweapons:kriss_sv"] =   "rangedweapons:9mm",
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
dofile(modpath.."/arms/ammo.lua")
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
		
		--error("non_existent arm: "..arm)
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
	core.chat_send_player(Name(p), core.colorize("#A67979", "-$"..tostring(a)).." "..core.colorize("#FF9D00", "On Buying "..tostring(m)))
end

function SendOnFail(p, a)
	core.chat_send_player(Name(p), core.colorize("#A67979", "Failed On Buy: "..tostring(a)..", No money?"))
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

--later this function will be linked
function cs_shop.save_state(pn, _, arm)
	if pn and arm then
		get_named[pn] = RecognizeType(arm)
		if get_named[pname] == "rifle" or get_named[pn] == "shotgun" then
			to_check[pn] = "arms_type_1"
		elseif get_named[pn] == "pistol" or get_named[pn] == "smg" then
			to_check[pn] = "arms_type_2"
		end
		local player = Player(pn)
		for _, typed in pairs(player:get_inventory():get_list("main")) do
			pnamee[pn] = typed:get_name()
			for _, name in pairs(cs_shop.arms[to_check[pn]]) do
				if pnamee == name then
					local stack = ItemStack(arm)
					inventory[pname]:remove_item("main", stack)
					minetest.item_drop(stack, Player(pn), Player(pn):get_pos())
					return true
				end
			end
		end
	end
end

function cs_shop.buy_ammo(ammo, pl)
	assert(ammo, "No ammo presense found")
	p = Player(pl)
	local pname = p:get_player_name()
	if cs_shop.ammo_values[ammo] then
		--error()
		his_money[pname] = bank.return_val(pname)
		if (his_money[pname] >= cs_shop.ammo_values[ammo]) then
			inventory[pname] = p:get_inventory()
			local amount = cs_shop.ammo_drops[ammo] or 80
			inventory[pname]:add_item("main", ItemStack("rangedweapons:"..ammo.." "..tostring(amount)))
			SendOnBuy(p, ammo, cs_shop.ammo_values[ammo])
			bank.rm_player_value(pname, cs_shop.ammo_values[ammo])
		else
			SendOnFail(p, t)
		end
	end
end

function cs_shop.buy_grenade(gr, p, t)
	local pname = Name(p)
	his_money[pname] = bank.return_val(pname) or 0
	if IsGrenade(gr) and p then
		if (his_money[pname] >= cs_shop.grenades_values[gr]) then
			if cs_shop.grenades[t][pname] ~= cs_shop.grenades_amounts[gr] then
				inventory[pname] = p:get_inventory()
				inventory[pname]:add_item("main", ItemStack(gr))
				cs_shop.grenades[t][pname] = cs_shop.grenades[t][pname] + 1
				SendOnBuy(p, t, cs_shop.grenades_values[gr])
				bank.rm_player_value(pname, cs_shop.grenades_values[gr])
			end
		else
			SendOnFail(p, t)
		end
		his_money[pname] = nil
		inventory[pname] = nil
	end
end

function cs_shop.buy_arm(arm, p)
	--print("a")
	local pname = Name(p)
	local player = Player(p)
	inventory[pname] = player:get_inventory()
	if type(arm) == "string" then
		--print("b")
		get_named[pname] = RecognizeType(arm)
		
		if get_named[pname] == "rifle" or get_named[pname] == "shotgun" then
			to_check[pname] = "arms_type_1"
			--print("c1")
		elseif get_named[pname] == "pistol" or get_named[pname] == "smg" then
			to_check[pname] = "arms_type_2"
			--print("c2")
		end
		
		for _, typed in pairs(player:get_inventory():get_list("main")) do
			--print("d")
			local name = typed:get_name()
			for i, str in pairs(cs_shop.arms[to_check[pname]]) do
				--print("h")
				if str == name then
					--print("i")
					local stack = ItemStack(str)
					inventory[pname]:remove_item("main", stack)
					minetest.item_drop(typed, player, player:get_pos())
					
					
					local a1 = RecognizeType(str)
					local ammo = cs_shop.arms_ammo[a1][str]
					if cs_shop.arms_ammo[a1].exe_amount then
						--print("j")
						local amount = cs_shop.arms_ammo[a1].ammo_amount
						local stack = ItemStack(tostring(cs_shop.arms_ammo[a1][str]).." "..tostring(amount))
						inventory[pname]:remove_item("main", stack)
						minetest.item_drop(stack, player, player:get_pos())
					else
						--print("k")
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
			--print("l")
			inventory[pname]:add_item("main", ItemStack(arm))
			if cs_shop.arms_ammo[RecognizeType(arm)].exe_amount then
				--print("m")
				v = cs_shop.arms_ammo[RecognizeType(arm)].ammo_amount
			end
			if v then
				--print("p")
				--print(RecognizeType(arm), arm)
				inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(arm)][arm].." "..v))
			else
				inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(arm)][arm]))
				--print("q")
			end
			SendOnBuy(p, ItemStack(arm):get_short_description(), cs_shop.arms_values[arm])
			bank.rm_player_value(pname, money_value[pname] + cs_shop.ammo_val)
			--error()
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
	if field.shotgun then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:shotgun", cs_shop.shotgun(name))
	end
	if field.smg then
		local name = player:get_player_name()
		minetest.show_formspec(name, "cs_shop:smg", cs_shop.smg(name))
	end
	if field.buy_rammo then
		cs_shop.buy_ammo_for_hard_arm(player)
	end
	if field.buy_pammo then
		cs_shop.buy_ammo_for_soft_arm(player)
	end
	if field.exit then
		local name = player:get_player_name()
		minetest.disconnect_player(name, "Disconnected from gui (CsShop MSG)")
	end
end)

function cs_shop.buy_ammo_for_hard_arm(p)
	local player = Player(p)
	local pname = Name(p)
	for _, typed in pairs(player:get_inventory():get_list("main")) do
		if RecognizeType(typed:get_name()) == "rifle" or RecognizeType(typed:get_name()) == "shotgun" then
			his_money[pname] = bank.return_val(pname)
			if his_money[pname] >= cs_shop.ammo_val then
				local v
				if cs_shop.arms_ammo[RecognizeType(typed:get_name())].exe_amount then
					--print("m")
					v = cs_shop.arms_ammo[RecognizeType(typed:get_name())].ammo_amount
				end
				inventory[pname] = Inv(player)
				if v then
					inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()].." "..v))
					SendOnBuy(p, ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()]):get_short_description(), cs_shop.ammo_val)
					bank.rm_player_value(pname, cs_shop.ammo_val)
				else
					inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()]))
					SendOnBuy(p, ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()]):get_short_description(), cs_shop.ammo_val)
					bank.rm_player_value(pname, cs_shop.ammo_val)
				end
			else
				SendOnFail(player, "ammo")
			end
		end
	end
	his_money[pname] = nil
	inventory[pname] = nil
end

function cs_shop.buy_ammo_for_soft_arm(p)
	local player = Player(p)
	local pname = Name(p)
	for _, typed in pairs(player:get_inventory():get_list("main")) do
		if RecognizeType(typed:get_name()) == "smg" or RecognizeType(typed:get_name()) == "pistol" then
			his_money[pname] = bank.return_val(pname)
			if his_money[pname] >= cs_shop.ammo_val then
				local v
				if cs_shop.arms_ammo[RecognizeType(typed:get_name())].exe_amount then
					--print("m")
					v = cs_shop.arms_ammo[RecognizeType(typed:get_name())].ammo_amount
				end
				inventory[pname] = Inv(player)
				if v then
					inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()].." "..v))
					SendOnBuy(p, ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()]):get_short_description(), cs_shop.ammo_val)
					bank.rm_player_value(pname, cs_shop.ammo_val)
				else
					inventory[pname]:add_item("main", ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()]))
					SendOnBuy(p, ItemStack(cs_shop.arms_ammo[RecognizeType(typed:get_name())][typed:get_name()]):get_short_description(), cs_shop.ammo_val)
					bank.rm_player_value(pname, cs_shop.ammo_val)
				end
			else
				SendOnFail(player, "ammo")
			end
		end
	end
	inventory[pname] = nil
end

do
	if not minetest.settings:get_bool("cs_map.mapmaking", false) then
		function cs_shop.enable_shopping(player)
			if player then
			player:set_inventory_formspec(cs_shop.main(player:get_player_name()))
			enabled_to[Name(player)] = true
			disabled_to[Name(player)] = nil
			else
				for _, player in pairs(core.get_connected_players()) do
				--local playerr = core.get_player_by_name(player)
				player:set_inventory_formspec(cs_shop.main(player:get_player_name()))
				enabled_to[Name(player)] = true
				disabled_to[Name(player)] = nil
				end
			end
		end
		function cs_shop.disable_shopping(player)
			if player then
			player:set_inventory_formspec(cs_shop.fmain(player))
			enabled_to[Name(player)] = nil
			disabled_to[Name(player)] = true
			else
				for _, player in pairs(core.get_connected_players()) do
				--local playerr = core.get_player_by_name(player)
				player:set_inventory_formspec(cs_shop.fmain(player))
				enabled_to[Name(player)] = nil
				disabled_to[Name(player)] = true
				end
			end
		end
	elseif minetest.settings:get_bool("cs_map.mapmaking", false) then
		function cs_shop.disable_shopping() end
		function cs_shop.enable_shopping() end
	end
end

local function on_joinp(player)
	
end

local function on_step(dtime)
	cs_shop.time = cs_shop.time + dtime
	if cs_shop.time >= 1 then
		if cs_match.commenced_match ~= false then
			for i, val in pairs(enabled_to) do
				if val == true and i and (not cs_shop.queued[i]) then
					if Player(i) then
						Player(i):set_inventory_formspec(cs_shop.main(i))
					end
				end
			end
			for i, val in pairs(disabled_to) do
				if val == true and i and (not cs_shop.queued[i]) then
					if Player(i) then
						Player(i):set_inventory_formspec(cs_shop.fmain())
					end
				end
			end
			
			local list = core.get_connected_players()
			for i, val in pairs(cs_shop.queued) do
				for _, player in pairs(list) do
					if Name(player) == i then
						if val == 0 then
							Player(i):set_inventory_formspec(cs_shop.fmain())
							disabled_to[Name(player)] = true
							enabled_to[Name(player)] = nil
							cs_shop.queued[Name(player)] = nil
						else
							cs_shop.queued[i] = cs_shop.queued[i] - 1
							Player(i):set_inventory_formspec(cs_shop.main(i))
							disabled_to[Name(player)] = nil
							enabled_to[Name(player)] = true
						end
					end
				end
			end
		end
		cs_shop.time = 0
	end
end

-- time to link
do
	cs_buying = table.copy(cs_shop)
	central = table.copy(cs_shop)
	 -- here is linked!
	central.save_state_pistol = cs_shop.save_state
	central.save_state_arm = cs_shop.save_state
	central.save_state_shotgun = cs_shop.save_state
	central.save_state_smg = cs_shop.save_state
	central.save_state_rifle = cs_shop.save_state
end

minetest.register_on_joinplayer(function(player)
	local p=player:get_player_name()
	cs_shop.grenades.frag[p] = 0
	cs_shop.grenades.flashbang[p] = 0
	cs_shop.grenades.smoke[p] = 0
	cs_shop.grenades.frag_sticky[p] = 0
end)
if minetest.settings:get_bool("cs_map.mapmaking", false) ~= true then
	core.register_globalstep(on_step)
end
--minetest.register_on_joinplayer(on_joinp)

call.register_on_player_join_team(function(player, team)
	if team == "terrorist" then
		cs_shop.enable_shopping(Player(player))
		cs_shop.queued[player] = 20
	elseif team == "counter" then
		cs_shop.enable_shopping(Player(player))
		cs_shop.queued[player] = 20
	end
end)





