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