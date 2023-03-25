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
    if formname ~= "central:smg" then
        return
    end
	pname = player:get_player_name()
	bank.place_values(pname)
	local money = playerv.money
	

    
	if fields.steyr then
        
        if (money > 80) or (money == 80) then
        --AntiCheat
        central.save_state_pistol(pname, "Steyr T.M.P", "rangedweapons:tmp")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 50)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:tmp")
    	local cmmm = core.colorize("#9B9B9B", "Steyr T.M.P")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$50 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for smg"))
        inventorytouse:add_item("main", "rangedweapons:9mm 100")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:smg", central.smg(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
		
	if fields.tec9 then
        
        if (money > 80) or (money == 80) then
        --AntiCheat
        central.save_state_pistol(pname, "Tec9", "rangedweapons:tec9")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 50)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:tec9")
    	local cmmm = core.colorize("#9B9B9B", "Tec9")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$50 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for Berettas"))
        inventorytouse:add_item("main", "rangedweapons:9mm 100")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:smg", central.smg(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.usi then
        
        if (money > 90) or (money == 90) then
        --AntiCheat
        central.save_state_pistol(pname, "UZI", "rangedweapons:uzi")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 60)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:uzi")
    	local cmmm = core.colorize("#9B9B9B", "UZI")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$60 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for UZI"))
        inventorytouse:add_item("main", "rangedweapons:9mm 100")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:smg", central.smg(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.kriss then
        
        if (money > 80) or (money == 80) then
        --AntiCheat
        central.save_state_pistol(pname, "Kriss Super V", "rangedweapons:kriss_sv")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 50)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:kriss_sv")
    	local cmmm = core.colorize("#9B9B9B", "Kriss Super V")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$50 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        if (money > 30) then
        bank.rm_player_value(pname, 30)
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$30 By Buying ammo for smg"))
        inventorytouse:add_item("main", "rangedweapons:9mm 100")
        end
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:smg", central.smg(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
end)
function central.smg(name)
    local text = money

    local formspece = {
        "formspec_version[6]" ..
	"size[10.5,9]" ..
	"box[5.9,0;4.7,1;#1cfc03]" ..
	"box[0,0;5.9,1;#fc6603]" ..
	"label[0.2,0.5;SMGs Shop]" ..
	"image_button[0.1,1.2;8.8,1.4;rangedweapons_tmp_icon.png;steyr;Steyr T.M.P\n80$\n9x9mm Parabellum;false;true]" ..
	"image_button[0.1,2.8;8.8,1.4;rangedweapons_tec9_icon.png;tec9;Tec9\n80$\n9x9mm Parabellum;false;true]" ..
	"image_button[0.1,4.4;8.8,1.4;rangedweapons_uzi_icon.png;usi;UZI\n90$\n9x9mm Parabellum;false;true]" ..
	"image_button[0.1,6;8.8,1.4;rangedweapons_kriss_sv_icon.png;kriss;Kriss Super V\n$80\n9x9mm Parabellum;false;true]" ..
	"list[current_player;main;0.4,7.8;8,1;0]" ..
	"button_exit[9,1.1;1.4,6.3;;E\nX\nI\nT]" ..
	"label[6.1,0.5;Money: "..money.."]"

    }

    -- table.concat is faster than string concatenation - `..`
    return table.concat(formspece, "")
end
