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
end
core.register_globalstep(on_step)