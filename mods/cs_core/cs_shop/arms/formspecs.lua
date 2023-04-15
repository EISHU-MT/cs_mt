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
	"label[6.1,0.5;Money: "..tostring(bank.return_val(name)).."]"
	}
	return table.concat(formspece, "")
end
function cs_shop.grenade(name)
	local text = money
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