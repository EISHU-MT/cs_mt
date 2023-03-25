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
    if formname ~= "central:grenade" then
        return
    end
	pname = player:get_player_name()
	bank.place_values(pname)
	local money = playerv.money
    
	if fields.nbomb then
        
        if (money > 100) or (money == 100) then
        --AntiCheat
        central.save_state_grenade(pname, "normal_grenade")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 57)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "grenades:frag")
    	local cmmm = core.colorize("#9B9B9B", "Grenade")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$100 By Buying " .. cmmm .. ""))   
        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:grenade", central.grenade(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
		
	if fields.flashbang then
        
        if (money > 70) or (money == 70) then
        --AntiCheat
        central.save_state_grenade(pname, "flashbang")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 70)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "grenades:flashbang")
    	local cmmm = core.colorize("#9B9B9B", "Flashbang")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$70 By Buying " .. cmmm .. ""))   

        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:grenade", central.grenade(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.smoke then
        
        if (money > 80) or (money == 80) then
        --AntiCheat
        central.save_state_grenade(pname, "smoke")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 80)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "grenades:smoke")
    	local cmmm = core.colorize("#9B9B9B", "Smoke")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$80 By Buying " .. cmmm .. ""))   

        
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:grenade", central.grenade(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.sfrag then
        
        if (money > 130) or (money == 130) then
        --AntiCheat
        central.save_state_grenade(pname, "sticky_frag")
        if (negative == true) then
        return
        end
        --End AntiCheat
        bank.rm_player_value(pname, 130)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "grenades:frag_sticky")
    	local cmmm = core.colorize("#9B9B9B", "Sticky Frag")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$130 By Buying " .. cmmm .. ""))   

        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:grenade", central.grenade(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
end)
function central.grenade(name)
    local text = money

    local formspece = {
        "formspec_version[6]" ..
	"size[10.5,9]" ..
	"box[0,0;6.4,1;#f75605]" ..
	"box[6.4,0;4.2,1;#39f705]" ..
	"label[0.3,0.5;Bombs shop]" ..
	"label[6.6,0.5;Money: "..text.."]" ..
	"image_button[0.2,1.2;3.2,3;grenades_frag.png;nbomb;Grenade\n100$\nCan carry 1;false;true]" ..
	"image_button[0.2,4.3;3.2,3;grenades_flashbang.png;flashbang;Flashbang\n70$\nCan carry 2;false;true]" ..
	"image_button[3.5,1.2;3.2,3;grenades_smoke_grenade.png;smoke;Smoke Grenade\n80$\nCan carry 1;false;true]" ..
	"image_button[3.5,4.3;3.2,3;grenades_frag_sticky.png;sfrag;Sticky Frag\n130$\nCan carry 1;false;true]" ..
	"list[current_player;main;0.4,7.8;8,1;0]" ..
	"label[7.8,7.1;Inventory]" ..
	"button_exit[7,1.5;3,0.8;;Exit]"

    }

    -- table.concat is faster than string concatenation - `..`
    return table.concat(formspece, "")
end
