ttable = {}
Declare("if_it", false)
Declare("if_it2", " ")
local function on_step()
	for pname in pairs(csgo.team.counter.players) do
		if Inv(pname):contains_item("main", ItemStack("bomb")) then
			Inv(pname):remove_item("main", ItemStack("bomb 65535"))
			core.item_drop(ItemStack("bomb"), Player(pname), Player(pname):get_pos())
		end
	end
	for pname in pairs(csgo.team.terrorist.players) do
		if Inv(pname):contains_item("main", ItemStack("bomb")) and has_bomb == pname then
			if_it = true
			if_it2 = pname
		elseif has_bomb ~= pname and Inv(pname):contains_item("main", ItemStack("bomb")) then
			Inv(pname):remove_item("main", ItemStack("bomb 65535"))
			core.item_drop(ItemStack("bomb"), Player(pname), Player(pname):get_pos())
		end
	end
	for _, player in pairs(core.get_connected_players()) do
		if cs_match.commenced_match ~= false then
			local usrd = player:get_wielded_item()
			local thing = usrd:get_name()
			if thing == ":" or thing == " " or thing == "" or thing == nil then
				player:set_physics_override({
					--gravity = 1090
					speed = 1.4,
					jump = 1.2
				})
			else
				player:set_physics_override({
					--gravity = 1090
					speed = 1,
					jump = 1
				})
			end
		end
	end
end
core.register_globalstep(on_step)