function armor.get_value(p)
	return armor.player[p:get_player_name()].avalue or 0
end
function armor.set_value(p, r)
	if type(armor.player[p:get_player_name()]) == "table" and tonumber(r) then
		v = tonumber(r)
		if v < 100 then
			v2 = v
		elseif v > 120 then
			v2 = 120
		elseif v < 20 then
			v2 = 20
		elseif v > 1 then
			v2 = v
		elseif v == -1 then -- debug only
			v2 = 0
		end
		if not tonumber(v2) then
			v2 = 0 -- TODO: replace 0 with variable `v`
		end
		armor.player[p:get_player_name()].avalue = v2
		local _, sus = armor.edit_fleshy(p, v2)
		upgrade(p)
		if armor.refer[p:get_player_name()] == false then
			armor.refer[p:get_player_name()] = true
		end
	else
		clua.throw("CS:GO Armor API: Cant find the specified player in armor.player, does that player exists")
	end
end
function armor.set_nil_to(p) -- just saves 2 letters written ` 0`
	armor.set_value(clua.player(p), -1)
end