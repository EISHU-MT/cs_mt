gift = {
	registered = {[1] = {price=0, item="default:torch 10", name="Unavailable!"}},
	names = {"Unavailable!"},
	selected_ones = {}
}
local function randomize()
	local t = {"#00BDFF", "#00FF20", "#FFFD00", "#F500FF", "#0014FF"}
	return Randomise("", t)
end
local function tableconcat(elements)
	local t = {}
	print(elements)
	for i, element in pairs(elements) do
		table.insert(t, randomize()..element)
	end
	return table.concat(t, ",")
end
function gift.process_formspec(elements, element_to_buy, balance, price, index)
	local index = index or "1"
	return "formspec_version[6]" ..
	"size[6,7]" ..
	"box[-0.2,0;6.2,0.7;#00D5FF]" ..
	"label[0.1,0.3;Global shop]" ..
	"textlist[0.1,0.8;5.8,4.3;selected;"..tableconcat(elements)..";"..index..";false]" ..
	"style[buy;textcolor=red]" ..
	"button[0.1,6.1;5.8,0.8;buy;Buy]" ..
	"label[0.1,5.8;You will buy: "..element_to_buy..", Price: "..core.colorize("#00BDFF", price).."]" ..
	"label[0.1,5.4;Balance (score): "..core.colorize("#00BDFF", balance).."]"
end

function gift.process_selectedByForm(index)
	local item = gift.registered[index]
	local name = item.name
	if item then
		return name, item.item, item.price, item
	end
end

local c = core.colorize

function gift.buy(player, item)
	if item.on_buy then
		item.on_buy(player, item)
		score.rmv_score_to(player, item.price)
		return
	end
	local itemS = ItemStack(item.item)
	if score.get_storedDA()[Name(player)] >= item.price then
		score.rmv_score_to(player, item.price)
		Inv(player):add_item("main", itemS)
		local item_name = itemS:get_short_description()
		core.chat_send_player(Name(player), c("#00FF20", "[G.S.] ")..c("#00C819", "You received ")..c("#009C14", item_name)..c("#00C819", ", substracted score from you: ")..c("#DDFF00", tostring(item.price).."."))
	else
		core.chat_send_player(Name(player), c("#00FF20", "[G.S.]")..c("#00C819", " No enough score."))
	end
end

local function on_fc(player, fn, fs)
	local name = Name(player)
	if fn == "gift:menu" then
		if fs.selected then
			local list = core.explode_textlist_event(fs.selected)
			local selected = gift.registered[list.index]
			--print(gift.registered[list.index])
			--print(dump(list))
			if not selected then return end
			selected.index = list.index
			gift.selected_ones[name] = selected
			core.after(0.3, function(name)
				core.show_formspec(name, "gift:menu", gift.process_formspec(gift.names, gift.selected_ones[name].name, score.get_score_of(name), gift.selected_ones[name].price, gift.selected_ones[name].index))
			end, name)
		end
		if fs.buy then
			if gift.selected_ones[name] then
				gift.buy(player, gift.selected_ones[name])
				core.after(0.3, function(name)
					core.show_formspec(name, "gift:menu", gift.process_formspec(gift.names, gift.selected_ones[name].name, score.get_score_of(name), gift.selected_ones[name].price, gift.selected_ones[name].index))
				end, name)
			else
				core.chat_send_player(name, c("#00FF20", "[G.S.]")..c("#00C819", " You may look at those limited elements in the menu before buying, you selected nothing."))
			end
		end
	end
end

local function cmd_func(name, params)
	--csgo.do_afk_to(name)
	core.show_formspec(name, "gift:menu", gift.process_formspec(gift.names, "Nothing", score.get_score_of(player), "0"))
end

local command = {
	description = "Show global shop menu",
	privs = {interact=true,},
	func = cmd_func
}

function gift.register_element(name, data)
	if not data then return false       end
	if not data.item then return false  end
	if not data.name then return false  end
	if not data.price then return false end
	table.insert(gift.names, name)
	table.insert(gift.registered, {
		name = name,
		item = data.item,
		price = data.price,
		on_buy = data.on_buy or nil
	})
	return true
end

------

core.register_on_player_receive_fields(on_fc)
core.register_chatcommand("gs", command)


















