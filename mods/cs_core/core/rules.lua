local storage = minetest.get_mod_storage("core")
local S = minetest.get_translator("core")
rules = {
	queue = {}
}
rules.list = {
	S("1. No Hacked Clients!"),
	S("2. No swearing/cursing"),
	S("3. Respect others & Admins & Mods"),
	S("4. No sexual content"),
	S("5. No sharing private info"),
	S("6. No being rude."),
	S("-----------------"),
	S("Admins & Mods desitions are final"),
}
function rules.return_form()
	local rules = {
		"formspec_version[6]" ..
		"size[10.5,11]" ..
		"box[0,0;10.6,1.1;#FF8888]" ..
		"label[4.9,0.5;Rules]" ..
		"textlist[0.2,1.3;10.1,8.5;;"..table.concat(rules.list, ",")..";1;false]" ..
		"button_exit[0.2,10;4.9,0.8;accept;I Accept!]" ..
		"button_exit[5.4,10;4.9,0.8;x;I dont care!]"
	}
	return table.concat(rules, "")
end

minetest.register_on_player_receive_fields(function(player, formname, field)
	if formname ~= "core:rules" then return end
	
	if field.accept then
		csgo.compress_player(Name(player))
		core.chat_send_player(Name(player), "-!- Have fun friend!")
		csgo.show_menu(player)
		
	end
	if field.x then
		core.chat_send_player(Name(player), "You will be kicked for not accepting the rules!")
		core.disconnect_player(Name(player), "Not accepting the rules is not good!")
	end
end)

minetest.register_on_newplayer(function(player)
	core.show_formspec(Name(player), "core:rules", rules.return_form())
end)




















