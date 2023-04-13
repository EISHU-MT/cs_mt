armor = {
	player = {},
	refer = {},
	register_on_change_armor_value = {},
	enable = clua.get_bool("enable_armor", clua.get_table_value("central_csgo")),
}
clua.start_luat(core.get_modpath(core.get_current_modname()), "cs_armor")
--Main
minetest.register_on_joinplayer(function(ObjectRef, last_login)
	armor.player[ObjectRef:get_player_name()] = {}
	armor.player[ObjectRef:get_player_name()].avalue = 120
	hb.init_hudbar(ObjectRef, "armor", 0, 100)
	armor.refer[ObjectRef:get_player_name()] = false
	--hb.unhide_hudbar(ObjectRef, "armor")
end)
minetest.register_on_leaveplayer(function(ObjectRef, timed_out)
	armor.player[ObjectRef:get_player_name()].avalue = nil
	armor.player[ObjectRef:get_player_name()] = nil
	armor.refer[ObjectRef:get_player_name()] = false
end)

function armor.for_punch_to_fleshy(p,h,_,_,_,d)
	if p:get_player_name() then
		if armor.refer then -- *Strokes* *ACHOOO*
			if armor.refer[p:get_player_name()] == true then -- Fix bug: -** fleshy
				pn = p:get_player_name()
				hn = h:get_player_name()
				if pn == hn then 
					return
				end
				local a = math.random(1, 6)
				if type(armor.get_value) == "function" then
					b = armor.get_value(p)
				else
					return
				end
				local c = d + a
				local d = c - b
				armor.set_value(p, d)
			end
		end
	end
end

minetest.register_on_punchplayer(armor.for_punch_to_fleshy)

function armor.edit_fleshy(p, v)
	if not p then
		return false, "player_not_found"
	end
	if not v then
		return false, "value_not_found"
	end
	if not tonumber(v) then
		return false, "2nd_is_not_a_number"
	end
	if armor.enable then
		p:set_armor_groups({fleshy=v})
		return true, "have_been_set_successfully"
	else
		return false, "disabled"
	end
	for i = 1, #armor.register_on_change_armor_value do
		armor.register_on_change_armor_value[i](p, v)
	end
end
