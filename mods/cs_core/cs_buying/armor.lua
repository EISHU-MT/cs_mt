--[[
	Armor page for cs_buying
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
        minetest.chat_send_player(pname, core.colorize("#FF0000#FF0000#FF0000#FF0000#FF0000", "No Money."))
        end
    end
end)
--]]
central.defusers = {}
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "central:armor" then
		return
	end
	pname = player:get_player_name()
	bank.place_values(pname)
	local money = bank.return_val(pname) or playerv.money
	if fields.alle then
		if (money > 200) or (money == 200) then
			local aval = armor.get_value(player)
			if aval > 20 and aval < 130 then
				armor.set_value(player, 20)
				local cmmm = core.colorize("#9B9B9B", "Armor Protection: helmet+armor")
				minetest.chat_send_player(pname, core.colorize("#eb8634","-$200 By Buying " .. cmmm .. ""))
				bank.place_values(pname)
				central.prepare(pname)
				central.load(pname, "central:armor", armor.fr(pname))
				bank.rm_player_value(pname, 200)
			end
		else
			minetest.chat_send_player(pname, core.colorize("#FF0000","Can't buy, no money available"))
		end
	end
	if fields.helmet then
		if (money > 100) or (money == 100) then
			local aval = armor.get_value(player)
			if (aval > 20) then
				if aval <= 130 then
					local a1 = aval - 50
					if a1 < 20 then
						a2 = 20
					else
						a2 = a1
					end
					if not tonumber(a2) then
						a2 = 50
					end
					
					armor.set_value(player, a2)
					local cmmm = core.colorize("#9B9B9B", "Armor Protection: helmet")
					minetest.chat_send_player(pname, core.colorize("#eb8634","-$100 By Buying " .. cmmm .. ""))
					bank.place_values(pname)
					central.prepare(pname)
					central.load(pname, "central:armor", armor.fr(pname))
					bank.rm_player_value(pname, 100)
				end
			end
		else
			minetest.chat_send_player(pname, core.colorize("#FF0000","Can't buy, no money available"))
		end
	end
	if fields.defuser then
		if csgo.pot[pname] == "terrorist" then
			minetest.chat_send_player(pname, core.colorize("#FF0000","You can't buy a defuser! remember your a terrorist!"))
			return
		end
		if (money > 70) or (money == 70) then
			
				--armor.set_value(player, a2)
				
				
				local inventorytouse = minetest.get_inventory({ type="player", name=pname })
				inventorytouse:add_item("main", "core:defuser")
				
				local cmmm = core.colorize("#9B9B9B", "Defuser")
				minetest.chat_send_player(pname, core.colorize("#eb8634","-$70 By Buying " .. cmmm .. ""))
				bank.place_values(pname)
				central.prepare(pname)
				central.load(pname, "central:armor", armor.fr(pname))
				bank.rm_player_value(pname, 70)
		else
			minetest.chat_send_player(pname, core.colorize("#FF0000","Can't buy, no money available"))
		end
	end
end)



















