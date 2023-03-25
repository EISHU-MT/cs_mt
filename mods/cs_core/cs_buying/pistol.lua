--Pistols Formspecs and buying

-- NO-CHEAT addictions:






--[[
minetest.register_on_joinplayer(function(player)
local playername={name=player:get_player_name()}
pistols.ifp.player[playername.name] = {pistol = nil}
end)
--]]










function central.prepare(pname)
bank.place_values(pname)
money = playerv.money
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "central:pistol" then
        return
    end
	pname = player:get_player_name()
	bank.place_values(pname)
	local money = playerv.money
	
	if fields.deagle then
        
        if (money > 100) or (money == 100) then
        --AntiCheat
        central.save_state_pistol(pname, "Desert Eagle", "rangedweapons:deagle")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 100)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:deagle")
    	local cmmm = core.colorize("#9B9B9B", "Desert Eagle")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$100 By Buying " .. cmmm .. ""))   
        
        -- Feature
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for Deagle"))
        inventorytouse:add_item("main", "rangedweapons:44 60")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:pistol", central.pistol(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.glock then
        
        if (money > 60) or (money == 60) then
        --AntiCheat
        central.save_state_pistol(pname, "Glock 17", "rangedweapons:glock17")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 60)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:glock17")
    	local cmmm = core.colorize("#9B9B9B", "Glock 17")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$60 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for the Glock17"))
        bank.rm_player_value(pname, 30)
        inventorytouse:add_item("main", "rangedweapons:9mm 60")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:pistol", central.pistol(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
	if fields.mmmmm then
        
        if (money > 57) or (money == 57) then
        --AntiCheat
        central.save_state_pistol(pname, "m1991", "rangedweapons:m1991")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 57)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:m1991")
    	local cmmm = core.colorize("#9B9B9B", "m1991")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$57 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for m1991"))
        inventorytouse:add_item("main", "rangedweapons:45acp 60")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:pistol", central.pistol(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
		
	if fields.bereta then
        
        if (money > 57) or (money == 57) then
        --AntiCheat
        central.save_state_pistol(pname, "Beretta M9", "rangedweapons:beretta")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 57)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:beretta")
    	local cmmm = core.colorize("#9B9B9B", "Beretta M9")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$57  By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for Berettas"))
        inventorytouse:add_item("main", "rangedweapons:9mm 60")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:pistol", central.pistol(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.luger then
        
        if (money > 58) or (money == 58) then
        --AntiCheat
        central.save_state_pistol(pname, "Luger P08", "rangedweapons:luger")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 58)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:luger")
    	local cmmm = core.colorize("#9B9B9B", "Luger P08")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$58 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for Luger"))
        inventorytouse:add_item("main", "rangedweapons:9mm 60")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:pistol", central.pistol(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.maka then
        
        if (money > 50) or (money == 50) then
        --AntiCheat
        central.save_state_pistol(pname, "Makarov", "rangedweapons:makarov")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 50)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:makarov")
    	local cmmm = core.colorize("#9B9B9B", "Makarov")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$50 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for Makarov"))
        inventorytouse:add_item("main", "rangedweapons:9mm 60")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:pistol", central.pistol(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
end)
function central.pistol(name)
    local text = money

    local formspece = {
        "formspec_version[6]" ..
	"size[10.5,9]" ..
	"box[0,0;6.2,1;#ff6600]" ..
	"label[4.8,0.5;Pistols]" ..
	"box[6.2,0;4.5,1;#00cc00]" ..
	"label[6.4,0.5;Money:]" ..
	"label[8.2,0.5;", minetest.formspec_escape(text), "]" ..
	"button[0.3,1.3;9.9,0.8;maka;Makarov $50]" ..	
	"button[0.3,2.4;9.9,0.8;luger;Luger $58]" ..
	"button[0.3,3.5;9.9,0.8;bereta;Beretta $57]" ..
	"button[0.3,4.6;9.8,0.8;mmmmm;m1991 $57]" ..
	"button[0.3,5.7;9.8,0.8;glock;Glock 17 $60]" ..
	"button[0.3,6.8;9.8,0.8;deagle;Desert Eagle $100]" ..
	"list[current_player;main;0.3,7.8;8,1;0]" ..
	"button_exit[0.5,0.1;3,0.8;kkk;Exit (ESC)]"

    }

    -- table.concat is faster than string concatenation - `..`
    return table.concat(formspece, "")
end
