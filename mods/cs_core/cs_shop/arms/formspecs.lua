local S = minetest.get_translator("cs_shop")
function cs_shop.pistol(name)
	local formspece = {
	"formspec_version[6]" ..
	"size[10.5,9]" ..
	"box[0,0;6.2,1;#ff6600]" ..
	"label[4.8,0.5;Pistols]" ..
	"box[6.2,0;4.5,1;#00cc00]" ..
	"label[6.4,0.5;Money:]" ..
	"label[8.2,0.5;", minetest.formspec_escape(bank.return_val(name)), "]" ..
	"button[0.3,1.3;9.9,0.8;makarov;Makarov $50]" ..	
	"button[0.3,2.4;9.9,0.8;luger;Luger $58]" ..
	"button[0.3,3.5;9.9,0.8;beretta;Beretta $57]" ..
	"button[0.3,4.6;9.8,0.8;m1991;m1991 $57]" ..
	"button[0.3,5.7;9.8,0.8;glock;Glock 17 $60]" ..
	"button[0.3,6.8;9.8,0.8;deagle;Desert Eagle $100]" ..
	"list[current_player;main;0.3,7.8;8,1;0]" ..
	"button_exit[0.5,0.1;3,0.8;kkk;Exit (ESC)]"
}
	return table.concat(formspece, "")
end

function cs_shop.smg(name)
	local formspece = {
	"formspec_version[6]" ..
	"size[10.5,9]" ..
	"box[5.9,0;4.7,1;#1cfc03]" ..
	"box[0,0;5.9,1;#fc6603]" ..
	"label[0.2,0.5;SMGs Shop]" ..
	"image_button[0.1,1.2;8.8,1.4;rangedweapons_tmp_icon.png;steyr;Steyr T.M.P\n80$\n9x9mm Parabellum;false;true]" ..
	"image_button[0.1,2.8;8.8,1.4;rangedweapons_tec9_icon.png;tec9;Tec9\n80$\n9x9mm Parabellum;false;true]" ..
	"image_button[0.1,4.4;8.8,1.4;rangedweapons_uzi_icon.png;usi;UZI\n90$\n9x9mm Parabellum;false;true]" ..
	"image_button[0.1,6;8.8,1.4;rangedweapons_kriss_sv_icon.png;kriss;Kriss Super V\n$80\n9x9mm Parabellum;false;true]" ..
	"list[current_player;main;0.4,7.8;8,1;0]" ..
	"button_exit[9,1.1;1.4,6.3;;E\nX\nI\nT]" ..
	"label[6.1,0.5;Money: "..tostring(bank.return_val(name) or "failed res..").."]"
	}
	return table.concat(formspece, "")
end
function cs_shop.grenade(name)
	local text = bank.return_val(name) or "failed res.."
	local formspece = {
	"formspec_version[6]" ..
	"size[10.5,9]" ..
	"box[0,0;6.4,1;#f75605]" ..
	"box[6.4,0;4.2,1;#39f705]" ..
	"label[0.3,0.5;Bombs shop]" ..
	"label[6.6,0.5;Money: "..text.."]" ..
	"image_button[0.2,1.2;3.2,3;grenades_frag.png;nbomb;Grenade\n100$\nCan carry 1;false;true]" ..
	"image_button[0.2,4.3;3.2,3;grenades_flashbang.png;flashbang;Flashbang\n70$\nCan carry 2;false;true]" ..
	"image_button[3.5,1.2;3.2,3;grenades_smoke_grenade.png;smoke;Smoke Grenade\n80$\nCan carry 1;false;true]" ..
	"image_button[3.5,4.3;3.2,3;grenades_frag_sticky.png;sfrag;Sticky Frag\n130$\nCan carry 1;false;true]" ..
	"list[current_player;main;0.4,7.8;8,1;0]" ..
	"label[7.8,7.1;Inventory]" ..
	"button_exit[7,1.5;3,0.8;;Exit]"
	}
	return table.concat(formspece, "")
end
function cs_shop.ammo(name)
	-- TODO: modify prices of every ammo type
	local formspecc = {
	"formspec_version[6]" ..
	"size[10.5,14.5]" ..
	"box[0,0;6.2,1;#33cc33]" ..
	"label[0.2,0.5;Ammunation]" ..
	"box[6.2,0;4.3,1;#00ff00]" ..
	"label[6.4,0.5;Money: ]" ..
	"label[8.3,0.5;$" .. tostring(bank.return_val(name) or "failed res..") .. "]" ..
	"button[0.3,1.3;9.9,0.8;diemm;10mm $50]" ..
	"button[0.3,2.4;9.9,0.8;winchester;.308 Winchester Round $50]" ..
	"button[0.3,3.5;9.9,0.8;magnum;.357 Magnum Round $50]" ..
	"button[0.3,4.6;9.9,0.8;cheytac;.408 Chey Tac $50]" ..
	"button[0.3,5.7;9.9,0.8;mmg;.40mm Grenade $50]" ..
	"button[0.3,6.8;9.9,0.8;magnumr;.44 Magnum Round $50]" ..
	"button[0.3,7.9;9.9,0.8;acp;.45 ACP Catridge $50]" ..
	"button[0.3,9;9.9,0.8;ae;.50 AE Catridge $50]" ..
	"button[0.3,10.1;9.9,0.8;seimm;5.56mm Round $50]" ..
	"button[0.3,11.2;9.9,0.8;sietemm;7.62mm Round $50]" ..
	"button[0.3,12.3;9.9,0.8;nueve;9x19mm Parabellum $50]" ..
	"button[0.3,13.4;9.9,0.8;gauge;12 Gauge Shell $50]"
	}
	return table.concat(formspecc, "")
end

function cs_shop.main(name)
	local moneyr = tostring(bank.return_val(name) or "Error: 1")
	local formspec = {
	"formspec_version[6]" ..
	"size[10.2,11]" ..
	"box[0,0;6.2,1;#00bfff]" ..
	"box[6.2,0;5.2,1;#00cc00]" ..
	"button[0.2,1.3;3,1.6;rifle;Rifles]" ..
	"button[3.2,1.3;3,1.6;pistol;"..S('Pistols').."]" ..
	"button[0.2,2.9;3,1.6;grenade;"..S('Grenades').."]" ..
	"button[0.2,6.1;3,1.6;sniper;"..S('Snipers').."]" ..
	"button[0.2,4.5;3,1.6;armor;"..S('Armor').."]" ..
	"button[3.2,2.9;3,1.6;shotgun;"..S('Shotguns').."]" ..
	"button[3.2,4.5;3,1.6;smg;Smgs]" ..
	"button[3.2,6.1;3,1.6;ammo;"..S('Ammo').."]" ..
	"list[current_player;main;0.2,8.5;8,2;0]" ..
	"label[4.4,8.1;Inventory]" ..
	"label[2.3,0.5;"..S('Shop & Menu').."]" ..
	"label[6.3,0.5;"..S('Total money:').."]" ..
	"label[8.7,0.5;  " .. moneyr .. "]" ..
	"box[6.5,1.3;3.4,1.4;#800000]" ..
	"button[6.7,1.6;3,0.8;exit;"..S('Exit of the game').."]" ..
	"button_exit[6.7,6.1;3,1.6;eee;"..S('Exit').." (ESC)]"
	}
	return table.concat(formspec, "")
end

function cs_shop.rifle(name)
	local text = tostring(bank.return_val(name) or "failed res..")
	local formspecee = {
	"formspec_version[6]" ..
	"size[10.5,10.8]" ..
	"box[0,8.3;10.5,0.4;#050505]" ..
	"box[0,0.9;4.8,7.4;#f0211a]" ..
	"box[7.2,0;3.3,0.9;#30fc03]" ..
	"box[0,0;7.2,0.9;#fc5203]" ..
	"label[0.1,0.4;Rifles and Snipers]" ..
	"label[7.4,0.4;Money: " .. text .."]" ..
	"image_button[0.2,1.6;4.3,1.4;rangedweapons_awp_icon.png;awp;AWP\n300$\n7.62mm;false;true]" .. -- Update V0.6
	"image_button[0.2,3.2;4.3,1.4;rangedweapons_svd_icon.png;svd;SVD\n250$\n7.62mm;false;true]" ..
	"image_button[0.2,4.8;4.3,1.4;rangedweapons_m200_icon.png;m200;M200\n320$\n.408 Chey Tac;false;true]" ..
	"label[1.8,1.2;Snipers]" ..
	"box[5.1,0.9;5.4,7.4;#f07a1a]" ..
	"box[4.8,0.9;0.3,7.4;#050505]" ..
	"label[6.7,1.2;Assault Rifles]" ..
	"image_button[5.3,1.6;5,1.4;rangedweapons_m16_icon.png;m16;M16\n190$\n5.56mm rounds;false;true]" ..
	"image_button[5.3,3.2;5,1.4;rangedweapons_g36_icon.png;g36;G36\n$200\n5.56mm rounds;false;true]" ..
	"image_button[5.3,4.8;5,1.4;rangedweapons_ak47_icon.png;ak47;AK-47\n250$\n7.62mm rounds;false;true]" ..
	"image_button[5.3,6.4;5,1.4;rangedweapons_scar_icon.png;scar;FN SCAR 16\n270$\n7.62/5.56mm round;false;true]" ..
	"list[current_player;main;0.4,9.6;8,1;0]" ..
	"label[4.6,9.1;Inventory]"
	}
	return table.concat(formspecee, "")
end

function cs_shop.shotgun(name)
	local text = tostring(bank.return_val(name) or "failed res..")
	local formspecee = {
	"formspec_version[6]" ..
	"size[7.6,8.2]" ..
	"box[0,0;4.8,1;#B60000]" ..
	"box[3.6,1;4.1,7.4;#FFC100]" ..
	"box[0,1;3.6,7.4;#78FF78]" ..
	"box[4.8,0;3.6,1;#00FF00]" ..
	"label[1.2,0.5;Shotguns Shop]" ..
	"label[5.4,0.5;Money: ", minetest.formspec_escape(text), "]" ..
	"button[0.2,2.2;3,1.6;remi;Remington 870 $65]" ..
	"label[0.1,1.8;Normal Shotguns:]" ..
	"button[0.2,4;3,1.6;spas;Spas-12 $75]" ..
	"button[0.2,5.8;3,1.6;beneli;Benelli m3 $70]" ..
	"label[3.9,1.8;Automatic Shotguns:]" ..
	"button[3.9,2.2;3,1.6;jackh;JackHammer $120]" ..
	"button[3.9,4;3,1.6;aa;AA-12 $100]"
	}
	return table.concat(formspecee, "")
end

function cs_shop.armor(name, m)
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

function cs_shop.fmain(name)
	local formspec = {
		"formspec_version[6]" ..
		"size[10.5,5]" ..
		"box[0,0;10.7,0.9;#fc0303]" ..
		"label[0.2,0.4;"..S('The Shop has been expired on new match will be available again').."]" ..
		"list[current_player;main;0.4,1.4;8,2;0]" ..
		"button_exit[0.8,4;8.5,0.8;;"..S('Exit').."]"
		}
	return table.concat(formspec, "")
end

