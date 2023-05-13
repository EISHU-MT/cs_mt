function Player(p)
	if type(p) == "userdata" then
		return p
	elseif type(p) == "string" then
		return core.get_player_by_name(p)
	end
end
function Name(p)
	if type(p) == "string" then
		return p
	elseif type(p) == "userdata" then
		return p:get_player_name()
	end
end
function Inv(p)
	return Player(p):get_inventory()
end
function FindItem(player, item)
    if player and type(player) == "userdata" then
        if item then
            local inv = player:get_inventory()
            local list = inv:get_list("main")
            local str2 = ItemStack(item)
            --local units = #list
            for i, string in pairs(list) do
                if string:get_name() == str2:get_name() then
                    return true, "success_true"
                end
                
            end
            return false, "item_dont_exists"
        end
    end
end
function ItemFind(...) FindItem(...) end
function RandomPos(pos, rad)
	--local x_sign = math.random() < 0.25 and -0.5 or 0.5
	--local z_sign = math.random() < 0.25 and -0.5 or 0.5
	--local x_offset = x_sign + math.random(rad)
	--local z_offset = z_sign + math.random(rad)
	--pos.x = pos.x + x_offset
	--pos.z = pos.z + z_offset
	return pos
end

function Randomise(conditionn, etable) -- Primary AI (Only had table parser with random and `IF`)
	condition = {}
	--conditionS.timedout = 2
	--condition.selected, condition.value, condition.value1, condition.value2, condition.value3 = unpack(conditionn:split(" "))
	condition.selected = unpack(conditionn:split(" "))
	for number, string in pairs(conditionn:split(" ")) do
	--print(string, number)
		if string ~= "Select" then
			if condition.value == nil then
				if string then
					condition.value = string
					--print(condition.value)
				else
					condition.value = "UNIT.FALSE"
				end
			else
				condition["value"..number] = string
			end
			
		end
	end
	if condition.selected == "Select" and condition.value then
		if type(condition.value) == "number" then
			if type(etable) == "table" then
				if etable[condition.value] then
					return etable[condition.value]
				end
			end
		elseif condition.value == "random" then
			if type(etable) == "table" then
				if condition.value1 ~= nil then
					if type(condition.value1) == "number" then
						tmprandom = math.random(condition.value1)
						if etable[condition.value1] then
							return etable[condition.value1]
						end
					end
				elseif condition.value1 == nil then
					number = 0
					for numberr, _ in pairs(etable) do
						number = numberr-- + 1
					end
					tmprandom = math.random(number)
					if etable[tmprandom] then
						return etable[tmprandom]
					end
				end
			end
		end
	end
end

function AddPrivs(p, privs) -- name=string, privs=table
	local name = Name(p)
	
	local player_privs = minetest.get_player_privs(name)
	for i, value in pairs(privs) do
		player_privs[i] = value
	end
	minetest.set_player_privs(name, player_privs)
end
--no
function DESTROY_THE_ENTIRE_UNIVERSE()
	_G = {haha_trolled = true}
end









