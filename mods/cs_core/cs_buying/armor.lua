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
armor.fr = armor.show_formspec
local S = minetest.get_translator("cs_buying")
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
				local cmmm = core.colorize("#9B9B9B", S('Armor Protection: helmet+armor'))
				minetest.chat_send_player(pname, core.colorize("#eb8634", "-$200"..S("By Buying")..cmmm))
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
					minetest.chat_send_player(pname, core.colorize("#eb8634", "-$100"..S("By Buying")..cmmm))
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



















