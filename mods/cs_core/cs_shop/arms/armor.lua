local S = minetest.get_translator("cs_shop")
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_shop:armor" then
		return
	end
	pname = player:get_player_name()
	local money = bank.return_val(pname)
	if fields.alle then
		if (money > 200) or (money == 200) then
			local aval = armor.get_value(player)
			if aval > 20 and aval < 130 then
				armor.set_value(player, 20)
				local cmmm = core.colorize("#9B9B9B", S('Armor Protection: helmet+armor'))
				minetest.chat_send_player(pname, core.colorize("#eb8634", "-$200"..S("By Buying")..cmmm))
				bank.rm_player_value(pname, 200)
				minetest.show_formspec(name, "cs_shop:armor", cs_shop.armor(pname))
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
					bank.rm_player_value(pname, 100)
					minetest.show_formspec(name, "cs_shop:armor", cs_shop.armor(pname))
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
				local inventorytouse = minetest.get_inventory({ type="player", name=pname })
				inventorytouse:add_item("main", "core:defuser")
				local cmmm = core.colorize("#9B9B9B", "Defuser")
				minetest.chat_send_player(pname, core.colorize("#eb8634","-$70 By Buying " .. cmmm .. ""))
				bank.rm_player_value(pname, 70)
				minetest.show_formspec(name, "cs_shop:armor", cs_shop.armor(pname))
		else
			minetest.chat_send_player(pname, core.colorize("#FF0000","Can't buy, no money available"))
		end
	end
end)