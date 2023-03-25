--Shotgun formspecs and buying (Copied and modified version of pistol.lua)

-- NO-CHEAT addictions:
















function central.prepare(pname)
bank.place_values(pname)
money = playerv.money
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "central:shotgun" then
        return
    end
	pname = player:get_player_name()
	bank.place_values(pname)
	local money = playerv.money
	
	if fields.remi then
        
        if (money > 65) or (money == 65) then
        --AntiCheat
        central.save_state_arm(pname, "Remington 870", "rangedweapons:remington")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 35)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:remington")
    	local cmmm = core.colorize("#9B9B9B", "Remington 870")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$35 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for shotgun"))
        inventorytouse:add_item("main", "rangedweapons:shell 50")
        
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:shotgun", central.shotgun(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.spas then
        
        if (money > 75) or (money == 75) then
        --AntiCheat
        central.save_state_arm(pname, "Spas-12", "rangedweapons:spas12")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 45)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:spas12")
    	local cmmm = core.colorize("#9B9B9B", "Spas-12")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$45 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for shotgun"))
        inventorytouse:add_item("main", "rangedweapons:shell 50")
        
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:shotgun", central.shotgun(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
	if fields.beneli then
        
        if (money > 70) or (money == 70) then
        --AntiCheat
        central.save_state_shotgun(pname, "Benelli m3", "rangedweapons:benelli")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 40)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:benelli")
    	local cmmm = core.colorize("#9B9B9B", "Benelli m3")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$40 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for shotgun"))
        inventorytouse:add_item("main", "rangedweapons:shell 50")
        
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:shotgun", central.shotgun(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
		
	if fields.jackh then
        
        if (money > 120) or (money == 120) then
        --AntiCheat
        central.save_state_shotgun(pname, "JackHammer", "rangedweapons:jackhammer")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 90)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:jackhammer")
    	local cmmm = core.colorize("#9B9B9B", "JackHammer")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$90 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for shotgun"))
        inventorytouse:add_item("main", "rangedweapons:shell 50")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:shotgun", central.shotgun(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.aa then
        
        if (money > 100) or (money == 100) then
        --AntiCheat
        central.save_state_shotgun(pname, "AA-12", "rangedweapons:aa12")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 70)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:aa12")
    	local cmmm = core.colorize("#9B9B9B", "AA-12")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$70 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for shotgun"))
        inventorytouse:add_item("main", "rangedweapons:shell 50")
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:shotgun", central.shotgun(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end

end)
function central.shotgun(name)
    local text = money

    local formspecee = {
        "formspec_version[6]" ..
	"size[7.6,8.2]" ..
	"box[0,0;4.8,1;#B60000]" ..
	"box[3.6,1;4.1,7.4;#FFC100]" ..
	"box[0,1;3.6,7.4;#78FF78]" ..
	"box[4.8,0;3.6,1;#00FF00]" ..
	"label[1.2,0.5;Shotguns Shop]" ..
	"label[5.4,0.5;Money: ", minetest.formspec_escape(text), "]" ..
	"button[0.2,2.2;3,1.6;remi;Remington 870 $65]" ..
	"label[0.1,1.8;Normal Shotguns:]" ..
	"button[0.2,4;3,1.6;spas;Spas-12 $75]" ..
	"button[0.2,5.8;3,1.6;beneli;Benelli m3 $70]" ..
	"label[3.9,1.8;Automatic Shotguns:]" ..
	"button[3.9,2.2;3,1.6;jackh;JackHammer $120]" ..
	"button[3.9,4;3,1.6;aa;AA-12 $100]"
	}
    return table.concat(formspecee, "")
end
