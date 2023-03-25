--Ammo Formspecs and buying

-- Ammunations

moneyts = 50


function central.prepare(pname)
bank.place_values(pname)
money = playerv.money
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "central:ammo" then
        return
    end
	pname = player:get_player_name()
	bank.place_values(pname)
	local money = playerv.money
	
	if fields.acp then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:45acp 85")
    	local cmmm = core.colorize("#9B9B9B", ".45ACP Catridge")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.ae then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:50ae 45")
    	local cmmm = core.colorize("#9B9B9B", ".50AE Catridge")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.magnumr then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:44 45")
    	local cmmm = core.colorize("#9B9B9B", ".44 Magnum Round")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.sietemm then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:762mm 55")
    	local cmmm = core.colorize("#9B9B9B", ".7.62mm Round")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.seimm then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:556mm 60")
    	local cmmm = core.colorize("#9B9B9B", ".5.56mm Round")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.magnum then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:357 45")
    	local cmmm = core.colorize("#9B9B9B", ".357 Magnum Round")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.nueve then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:9mm 100")
    	local cmmm = core.colorize("#9B9B9B", "9x9mm Parabellum")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
	
	if fields.gauge then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:shell 25")
    	local cmmm = core.colorize("#9B9B9B", "12 Gauge Shell")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
	if fields.winchester then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:308winchester 35")
    	local cmmm = core.colorize("#9B9B9B", ".304 Winchester Round")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
		
	if fields.diemm then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:10mm 40")
    	local cmmm = core.colorize("#9B9B9B", "10mm Auto.")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.cheytac then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:408cheytac 15")
    	local cmmm = core.colorize("#9B9B9B", ".408 Chey Tac")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
    if fields.mmg then
        if (money > moneyts) or (money == moneyts) then
        bank.rm_player_value(pname, moneyts)
        money = playerv.money
        local inventorytouse = minetest.get_inventory({ type="player", name=pname })
    	inventorytouse:add_item("main", "rangedweapons:40mm 5")
    	local cmmm = core.colorize("#9B9B9B", ".40mm Grenade")
        minetest.chat_send_player(pname, core.colorize("#eb8634","-$" .. moneyts .. " By Buying " .. cmmm .. ""))   
        bank.place_values(pname)
        money = playerv.money
        central.prepare(pname)
        central.load(pname, "central:ammo", central.ammo(name))
        else
        minetest.chat_send_player(pname, core.colorize("#FF0000", "No Money."))
        end
    end
    
end)

function central.ammo(name)
    -- TODO: display whether the last guess was higher or lower
    text = money
    local formspecc = {
        "formspec_version[6]" ..
	"size[10.5,14.5]" ..
	"box[0,0;6.2,1;#33cc33]" ..
	"label[0.2,0.5;Ammunation]" ..
	"box[6.2,0;4.3,1;#00ff00]" ..
	"label[6.4,0.5;Money: ]" ..
	"label[8.3,0.5;$" .. text .. "]" ..
	"button[0.3,1.3;9.9,0.8;diemm;10mm $50]" ..
	"button[0.3,2.4;9.9,0.8;winchester;.308 Winchester Round $50]" ..
	"button[0.3,3.5;9.9,0.8;magnum;.357 Magnum Round $50]" ..
	"button[0.3,4.6;9.9,0.8;cheytac;.408 Chey Tac $50]" ..
	"button[0.3,5.7;9.9,0.8;mmg;.40mm Grenade $50]" ..
	"button[0.3,6.8;9.9,0.8;magnumr;.44 Magnum Round $50]" ..
	"button[0.3,7.9;9.9,0.8;acp;.45 ACP Catridge $50]" ..
	"button[0.3,9;9.9,0.8;ae;.50 AE Catridge $50]" ..
	"button[0.3,10.1;9.9,0.8;seimm;5.56mm Round $50]" ..
	"button[0.3,11.2;9.9,0.8;sietemm;7.62mm Round $50]" ..
	"button[0.3,12.3;9.9,0.8;nueve;9x19mm Parabellum $50]" ..
	"button[0.3,13.4;9.9,0.8;gauge;12 Gauge Shell $50]"

    }

    -- table.concat is faster than string concatenation - `..`
    return table.concat(formspecc, "")
end
