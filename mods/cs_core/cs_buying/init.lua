--By EISHU
--CS_BUYING V2
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
	}
}

local S = minetest.get_translator("cs_buying")

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



central = {}
cs_buying = {}
local modpath = core.get_modpath(minetest.get_current_modname())

pistols = {} -- Pistols/SMGs
pistols.ifp = {}
pistols.ifp.player = {}

grenade = {} -- Grenades
grenade.ifp = {}
grenade.player = {playe4321r=false}
grenade.types = { -- Limit of every grenade
	sticky_frag = 1,
	normal_grenade = 1,
	flashbang = 2,
	smoke = 1
}

hard = {} -- WEAPON
hard.ifp = {}
hard.ifp.player = {}

minetest.register_on_joinplayer(function(player)
local playername={name=player:get_player_name()}
hard.ifp.player[playername.name] = {}
hard.ifp.player[playername.name].arm = {weapon_string = nil, weapon_item = nil}
pistols.ifp.player[playername.name] = {}
pistols.ifp.player[playername.name].arm = {weapon_string = nil, weapon_item = nil}
grenade.player[playername.name] = {}
grenade.player[playername.name].arm = {sticky_frag = 0, normal_grenade = 0, flashbang = 0, smoke = 0} -- Wipe user grenades
central.defusers[playername.name] = false
--print(grenade.player[playername.name].arm.sticky_frag)
end)

--Anticheat start
--[[
	if (hard.ifp.player[name].arm.weapon_string == nil and hard.ifp.player[name].arm.weapon_item == nil) then
	-- This line is deprecated
	--hard.ifp.player[name].arm = {weapon_string = weapon, weapon_item = weaponi}

	else
	minetest.chat_send_player(name, minetest.colorize("#FF9300", "You have bought a "..hard.ifp.player[name].arm.weapon_string.." already... dropping the old weapon"))
	if name then
	dropper = minetest.get_player_by_name(name)
	local pos = dropper:get_pos()
	--print(hard.ifp.player[name].arm.weapon_item)

	minetest.item_drop(ItemStack(hard.ifp.player[name].arm.weapon_item), dropper, pos)
	local itemst = ItemStack(hard.ifp.player[name].arm.weapon_item)
	local inv = dropper:get_inventory()
	core.after(0.01, function()
	inv:remove_item("main", itemst)
	end, itemst)
	core.after(0.05, function()
	hard.ifp.player[name].arm = {weapon_string = weapon, weapon_item = weaponi}
	end, name, weapon, weaponi)
	end
	negative = false
	end
]]
function central.save_state_arm(name, weapon, weaponi) -- Update: weapon = Weapon Name (nil) and weaponi = Weapon itemstring
	if weapon ~= false and weaponi then
		core.debug("warn", "Using *weapon* as a weapon text is deprecated, use only the weapon itemstring.")
	end
	core.debug("green", "central.save_state_arm() executing", "CS::Buying")
	Pname = clua.pname(name)
	Player = clua.player(name)
	--local table = arms.arms_type_1
	local res = clua.find_itemstack_from(Player, weaponi)
	inv = Player:get_inventory()
	local stack = ItemStack(weaponi)
	local pos = Player:get_pos()
	if res == true then
		core.debug("green", "result: true", "CS::Buying")
		minetest.item_drop(stack, Player, pos)
		local inv = Player:get_inventory()
		local stack = ItemStack(weaponi)
		core.after(0.4, function(stack, inv) -- Just for now.
			inv:remove_item("main", stack)
		end, stack, inv)
	else
		for _, str in pairs(arms.arms_type_1) do
			Res2 = clua.find_itemstack_from(Player, str)
			if Res2 == true then
				finded = true
				named = str
				break
			end
		end
		if finded and named then
		core.debug("green", "Dropping the old arm", "CS::Buying")
		minetest.chat_send_player(Pname, minetest.colorize("#FF9300", "You have bought a weapon already... dropping the old weapon.."))
			itemsasasas = ItemStack(named.." 1")
			--error(item:get_name() .." - ".. item:get_count()) 
			--print(named, finded)
			--error(named)
			minetest.item_drop(itemsasasas, Player, pos)

			--print(itemsasasas:get_name())

			inveeee = Player:get_inventory()

			core.after(0.5, function(namedd, achoo) -- Just for now.
				achoo:remove_item("main", ItemStack(namedd.." 1"))
				--error(ItemStack(namedd.." 1"):get_name())
			end, named, inveeee)
			

		end
	end
	
	named = nil
	finded = nil
	inveeee = nil
	itemsasasas = nil
	Pname = nil
	Player = nil
	inv = nil
end

--Making alias for shotguns
function central.save_state_shotgun(name, weapon, weaponi)
	central.save_state_arm(name, false, weaponi)
end



function central.save_state_grenade(name, grenadee) -- name: player name, grenade: type of grenade, see line 13.
	if name and grenadee then
		--Sticky Grenade
		if grenadee == "sticky_frag" then
			if grenade.player[name].arm.sticky_frag == grenade.types.sticky_frag then
				minetest.chat_send_player(name, minetest.colorize("#FF9300", "You already has a sticky frag..."))
				negative = true
			else
				grenade.player[name].arm.sticky_frag = grenade.player[name].arm.sticky_frag + 1
			end
		end
		-- Normal Grenade
		if grenadee == "normal_grenade" then
			if grenade.player[name].arm.normal_grenade == grenade.types.normal_grenade then
				minetest.chat_send_player(name, minetest.colorize("#FF9300", "You already bought a grenade...."))
				negative = true
			else
				grenade.player[name].arm.normal_grenade = grenade.player[name].arm.normal_grenade + 1
			end
		end
		-- Flashbang
		if grenadee == "flashbang" then
			if grenade.player[name].arm.flashbang == grenade.types.flashbang then
				minetest.chat_send_player(name, minetest.colorize("#FF9300", "You have bought already a flashbang...."))
				negative = true
			else
				grenade.player[name].arm.flashbang = grenade.player[name].arm.flashbang + 1
			end
		end
		-- Smoke
		if grenadee == "smoke" then
			if grenade.player[name].arm.smoke == grenade.types.smoke then
				minetest.chat_send_player(name, minetest.colorize("#FF9300", "You already has a smoke grenade in your inventory...."))
				negative = true
			else
				grenade.player[name].arm.smoke = grenade.player[name].arm.smoke + 1
			end
		end
	end
end

--[[
function central.save_state_shotgun(name, weapon, weaponi) -- ALIAS
if (hard.ifp.player[name].arm.weapon_string == nil and hard.ifp.player[name].arm.weapon_item == nil) then
hard.ifp.player[name].arm = {weapon_string = weapon, weapon_item = weaponi}
else
minetest.chat_send_player(name, minetest.colorize("#FF9300", "You have bought a "..hard.ifp.player[name].arm.weapon_string.." already... dropping the old weapon..."))
if name then
dropper = minetest.get_player_by_name(name)
local pos = dropper:get_pos()
--print(hard.ifp.player[name].arm.weapon_item)

minetest.item_drop(ItemStack(""..hard.ifp.player[name].arm.weapon_item..""), dropper, pos)
local itemst = ItemStack(hard.ifp.player[name].arm.weapon_item)
local inv = dropper:get_inventory()
core.after(0.2, function()
inv:remove_item("main", itemst)
end)
end
negative = false
end
end
--]]

function central.save_state_pistol(name, weapon, weaponi)
	if weapon ~= false and weaponi then
		core.debug("warn", "Using *weapon* as a weapon text is deprecated, use only the weapon itemstring.")
	end
	core.debug("green", "central.save_state_pistol() executing", "CS::Buying")
	Pname = clua.pname(name)
	Player = clua.player(name)
	--local table = arms.arms_type_1
	local res = clua.find_itemstack_from(Player, weaponi)
	inv = Player:get_inventory()
	local stack = ItemStack(weaponi)
	local pos = Player:get_pos()
	if res == true then
		core.debug("green", "result: true", "CS::Buying")
		minetest.item_drop(stack, Player, pos)
		local inv = Player:get_inventory()
		local stack = ItemStack(weaponi)
		core.after(0.4, function(stack, inv) -- Just for now.
			inv:remove_item("main", stack)
		end, stack, inv)
	else
		for _, str in pairs(arms.arms_type_2) do
			Res2 = clua.find_itemstack_from(Player, str)
			if Res2 == true then
				finded = true
				named = str
				break
			end
		end
		if finded and named then
		core.debug("green", "Dropping the old pistol: "..ItemStack(named.." 1"):get_description(), "CS::Buying")
		minetest.chat_send_player(Pname, minetest.colorize("#FF9300", "You have bought a pistol already... dropping the old pistol.."))
			itemsasasas = ItemStack(named.." 1")
			--error(item:get_name() .." - ".. item:get_count()) 
			--print(named, finded)
			--error(named)
			minetest.item_drop(itemsasasas, Player, pos)

			--print(itemsasasas:get_name())

			inveeee = Player:get_inventory()

			core.after(0.5, function(namedd, achoo) -- Just for now.
				achoo:remove_item("main", ItemStack(namedd.." 1"))
				--error(ItemStack(namedd.." 1"):get_name())
			end, named, inveeee)

		end
	end
	named = nil
	finded = nil
	inveeee = nil
	itemsasasas = nil
	Pname = nil
	Player = nil
	inv = nil
end




-- anticheat end

--Banks

minetest.register_on_joinplayer(function(player)
local playerare={name=player:get_player_name()}
bank.place_values(playerare.name)
money = playerv.money
end)


function central.preparee(pname)
bank.place_values(pname)
money = playerv.money
end





function central.load(pname, formname, formspec)
bank.place_values(pname)
money = playerv.money
minetest.show_formspec(pname, formname, formspec)
end

--Dofiles...
dofile(modpath.."/pistol.lua")
dofile(modpath.."/ammo.lua")
dofile(modpath.."/shotguns.lua")
dofile(modpath.."/rifles.lua")
dofile(modpath.."/armor.lua")
dofile(modpath.."/smgs.lua")
dofile(modpath.."/grenades.lua")


--Disable and change to normal when maked successfully.




function central.main(name)
    local moneyr = money
    local formspec = {
        "formspec_version[6]" ..
	"size[10.2,11]" ..
	"box[0,0;6.2,1;#00bfff]" ..
	"box[6.2,0;5.2,1;#00cc00]" ..
	"button[0.2,1.3;3,1.6;rifle;Rifles]" ..
	"button[3.2,1.3;3,1.6;pistol;"..S('Pistols').."]" ..
	"button[0.2,2.9;3,1.6;grenade;"..S('Grenades').."]" ..
	"button[0.2,6.1;3,1.6;sniper;"..S('Snipers').."]" ..
	"button[0.2,4.5;3,1.6;armor;"..S('Armor').."]" ..
	"button[3.2,2.9;3,1.6;shotgun;"..S('Shotguns').."]" ..
	"button[3.2,4.5;3,1.6;smg;Smgs]" ..
	"button[3.2,6.1;3,1.6;ammo;"..S('Ammo').."]" ..
	"list[current_player;main;0.2,8.5;8,2;0]" ..
	"label[4.4,8.1;Inventory]" ..
	"label[2.3,0.5;"..S('Shop & Menu').."]" ..
	"label[6.3,0.5;"..S('Total money:').."]" ..
	"label[8.7,0.5;  " .. moneyr .. "]" ..
	"box[6.5,1.3;3.4,1.4;#800000]" ..
	"button[6.7,1.6;3,0.8;exit;"..S('Exit of the game').."]" ..
	"button_exit[6.7,6.1;3,1.6;eee;"..S('Exit').." (ESC)]"
    }

    return table.concat(formspec, "")
end


function central.show_to(name)
    minetest.show_formspec(name, "central:shop", central.main(name))
end
--[[
minetest.register_chatcommand("game", {
    func = function(name)
    	central.preparee(name)
        central.show_to(name)
    end,
})
--]]


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "" then
        return
    end
    
    local playerr = player:get_player_name()
    bank.place_values(playerr)
	money = playerv.money
		
	if fields.ammo then
        local pname = player:get_player_name()
        minetest.show_formspec(pname, "central:ammo", central.ammo(name)) -- Load Ammo shopping
    	
    end
    
    if fields.rifle or fields.sniper then
        local pname = player:get_player_name()
        bank.place_values(pname)
        minetest.show_formspec(pname, "central:rifles", central.rifles(name)) -- Load Rifles or Snipers shopping
    end
    
    if fields.pistol then
        local pname = player:get_player_name()
        bank.place_values(pname)
        minetest.show_formspec(pname, "central:pistol", central.pistol(name)) -- Load Pistols shopping
    end
    
    if fields.grenade then
        local pname = player:get_player_name()
        bank.place_values(pname)
        minetest.show_formspec(pname, "central:grenade", central.grenade(name)) -- Load Grenades shopping
    end
    
    if fields.shotgun then
    local pname = player:get_player_name()
        bank.place_values(pname)
        minetest.show_formspec(pname, "central:shotgun", central.shotgun(name)) -- Load Shotguns shopping
    end
    
    if fields.smg then
    local pname = player:get_player_name()
        bank.place_values(pname)
        minetest.show_formspec(pname, "central:smg", central.smg(name)) -- Load SMGs shopping
    end
    
    if fields.armor then
    	local pname = player:get_player_name()
    	local a = core.find_mod("Armor", "cs_armor")
    	if a then
    		function armor.show_formspec(name, m)
			player = clua.player(name)
			if player then
				armor_value = armor.get_value(player)
				if not m then
					money = bank.return_val(name)
				else
					money = m
				end
			end
			form = {
			"formspec_version[6]" ..
			"size[10.5,10]" ..
			"box[7.3,0;3.2,1.3;#00C66D]" ..
			"label[7.4,0.6;Money: $"..tostring(money).."]" ..
			"box[0,0;7.3,1.3;#E87338]" ..
			"label[0.2,0.6;Armor Shop / Defusers]" ..
			"box[0,7.5;11.1,2.5;#FA5300]" ..
			"label[0.2,8;Armor Status: "..tostring(armor_value).."%]" ..
			"button_exit[0.2,9;10.1,0.8;on_exit;Exit]" ..
			"button[0.1,1.4;3.1,5.9;alle;Full Armor\nCosts: $200\n Helmet\n+\nArmor: 100%]" ..
			"button[3.7,1.4;3.1,5.9;helmet;Helmet Only\nCosts: $100\n Helmet: +50%]" ..
			"button[7.3,1.4;3.1,5.9;defuser;Defuser\nCosts: $70\n Defuser for bomb]"
			}
			return table.concat(form, '')
		end
    		minetest.show_formspec(pname, "central:armor", armor.show_formspec(playerr))
    	end
    end
    
    if fields.exit then
        local pname = player:get_player_name()
        minetest.kick_player(pname, S('Exiting of the game.....'))
    end
end)

if not map_edit then
minetest.register_on_joinplayer(function(player)


player:set_inventory_formspec(central.main(player))


end)
end


if not map_edit then



function central.fmain(name)
local formspec = {
	"formspec_version[6]" ..
	"size[10.5,5]" ..
	"box[0,0;10.7,0.9;#fc0303]" ..
	"label[0.2,0.4;"..S('The Shop has been expired on new match will be available again').."]" ..
	"list[current_player;main;0.4,1.4;8,2;0]" ..
	"button_exit[0.8,4;8.5,0.8;;"..S('Exit').."]"
	}
return table.concat(formspec, "")
end

function cs_buying.enable_shopping(player)
	if player then
	
	player:set_inventory_formspec(central.main(player))
	
	else
		for _, player in pairs(core.get_connected_players()) do
		--local playerr = core.get_player_by_name(player)
		player:set_inventory_formspec(central.main(player))
		end
	end
end

function cs_buying.disable_shopping(player)
	if player then
	
	player:set_inventory_formspec(central.fmain(player))
	
	else
		for _, player in pairs(core.get_connected_players()) do
		--local playerr = core.get_player_by_name(player)
		player:set_inventory_formspec(central.fmain(player))
		end
	end
end





end