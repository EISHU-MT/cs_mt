--Shotgun formspecs and buying (Copied and modified version of pistol.lua)

-- NO-CHEAT addictions:


--[[
call.register_on_new_match(function()
for __, player in pairs(core.get_connected_players()) do
local playername={name=player:get_player_name()}
hard.ifp.player[playername.name] = {}
hard.ifp.player[playername.name].arm = {weapon_string = nil, weapon_item = nil}
end
end)
--]]





--[[

function central.save_state_arm(name, weapon, weaponi) -- Update: weapon = Weapon Name (Remington 870) and weaponi = Weapon itemstring
if (hard.ifp.player[name].arm.weapon_string == nil and hard.ifp.player[name].arm.weapon_item == nil) then
hard.ifp.player[name].arm = {weapon_string = weapon, weapon_item = weaponi}
else
minetest.chat_send_player(name, minetest.colorize("#FF9300", "You have bought a "..hard.ifp.player[name].arm.weapon_string.." already... dropping the old weapon"))
if name then
dropper = minetest.get_player_by_name(name)
local pos = dropper:get_pos()
minetest.item_drop(hard.ifp.player[name].arm.weapon_item, dropper, pos)
end
negative = false
end
end


function central.save_state_shotgun(name, weapon, weaponi) -- ALIAS
if (hard.ifp.player[name].arm.weapon_string == nil and hard.ifp.player[name].arm.weapon_item == nil) then
hard.ifp.player[name].arm = {weapon_string = weapon, weapon_item = weaponi}
else
minetest.chat_send_player(name, minetest.colorize("#FF9300", "You have bought a "..hard.ifp.player[name].arm.weapon_string.." already... dropping the old weapon..."))
if name then
dropper = minetest.get_player_by_name(name)
local pos = dropper:get_pos()
minetest.item_drop(hard.ifp.player[name].arm.weapon_item, dropper, pos)
end
negative = false
end
end

--]]

function central.prepare(pname)
bank.place_values(pname)
money = playerv.money
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "central:rifles" then
        return
    end
	pname = player:get_player_name()
	bank.place_values(pname)
	local money = playerv.money
	
	if fields.g36 then
        
        if (money > 200) or (money == 200) then
        --AntiCheat
        central.save_state_arm(pname, "G36", "rangedweapons:g36")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 170)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:g36")
    	local cmmm = core.colorize("#9B9B9B", "G36")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$170 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for rifle/sniper"))
        inventorytouse:add_item("main", "rangedweapons:556mm 160")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:rifles", central.rifles(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.m16 then
        
        if (money > 190) or (money == 190) then
        --AntiCheat
        central.save_state_arm(pname, "M16", "rangedweapons:m16")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 160)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:m16")
    	local cmmm = core.colorize("#9B9B9B", "m16")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$160 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for rifle/sniper"))
        inventorytouse:add_item("main", "rangedweapons:556mm 160")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:rifles", central.rifles(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
	if fields.m200 then
        
        if (money > 320) or (money == 320) then
        --AntiCheat
        central.save_state_arm(pname, "M200", "rangedweapons:m200")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 290)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:m200")
    	local cmmm = core.colorize("#9B9B9B", "M200")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$290 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for rifle/sniper"))
        inventorytouse:add_item("main", "rangedweapons:408cheytac 50")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:rifles", central.rifles(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
		
	if fields.svd then
        
        if (money > 250) or (money == 250) then
        --AntiCheat
        central.save_state_arm(pname, "SVD", "rangedweapons:svd")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 220)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:svd")
    	local cmmm = core.colorize("#9B9B9B", "SVD")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$220 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for rifle/sniper"))
        inventorytouse:add_item("main", "rangedweapons:762mm 160")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:rifles", central.rifles(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.awp then
        
        if (money > 300) or (money == 300) then
        --AntiCheat
        central.save_state_arm(pname, "AWP", "rangedweapons:awp")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 270)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:awp")
    	local cmmm = core.colorize("#9B9B9B", "AWP")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$270 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for rifle/sniper"))
        inventorytouse:add_item("main", "rangedweapons:762mm 160")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:rifles", central.rifles(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.ak47 then
        
        if (money > 250) or (money == 250) then
        --AntiCheat
        central.save_state_arm(pname, "AK-47", "rangedweapons:ak47")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 220)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:ak47")
    	local cmmm = core.colorize("#9B9B9B", "AK-47")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$220 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for rifle/sniper"))
        inventorytouse:add_item("main", "rangedweapons:762mm 160")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:rifles", central.rifles(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.scar then
        
        if (money > 270) or (money == 270) then
        --AntiCheat
        central.save_state_arm(pname, "FN SCAR 16", "rangedweapons:scar")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 220)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:scar")
    	local cmmm = core.colorize("#9B9B9B", "FN SCAR 16")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$220 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for rifle/sniper"))
        inventorytouse:add_item("main", "rangedweapons:556mm 160")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:rifles", central.rifles(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end

end)
function central.rifles(name)
    local text = money

    local formspecee = {
        "formspec_version[6]" ..
	"size[10.5,10.8]" ..
	"box[0,8.3;10.5,0.4;#050505]" ..
	"box[0,0.9;4.8,7.4;#f0211a]" ..
	"box[7.2,0;3.3,0.9;#30fc03]" ..
	"box[0,0;7.2,0.9;#fc5203]" ..
	"label[0.1,0.4;Rifles and Snipers]" ..
	"label[7.4,0.4;Money: " .. text .."]" ..
	"image_button[0.2,1.6;4.3,1.4;rangedweapons_awp_icon.png;awp;AWP\n300$\n7.62mm;false;true]" .. -- Update V0.6
	"image_button[0.2,3.2;4.3,1.4;rangedweapons_svd_icon.png;svd;SVD\n250$\n7.62mm;false;true]" ..
	"image_button[0.2,4.8;4.3,1.4;rangedweapons_m200_icon.png;m200;M200\n320$\n.408 Chey Tac;false;true]" ..
	"label[1.8,1.2;Snipers]" ..
	"box[5.1,0.9;5.4,7.4;#f07a1a]" ..
	"box[4.8,0.9;0.3,7.4;#050505]" ..
	"label[6.7,1.2;Assault Rifles]" ..
	"image_button[5.3,1.6;5,1.4;rangedweapons_m16_icon.png;m16;M16\n190$\n5.56mm rounds;false;true]" ..
	"image_button[5.3,3.2;5,1.4;rangedweapons_g36_icon.png;g36;G36\n$200\n5.56mm rounds;false;true]" ..
	"image_button[5.3,4.8;5,1.4;rangedweapons_ak47_icon.png;ak47;AK-47\n250$\n7.62mm rounds;false;true]" ..
	"image_button[5.3,6.4;5,1.4;rangedweapons_scar_icon.png;scar;FN SCAR 16\n270$\n7.62/5.56mm round;false;true]" ..
	"list[current_player;main;0.4,9.6;8,1;0]" ..
	"label[4.6,9.1;Inventory]"
	}
    return table.concat(formspecee, "")
end
