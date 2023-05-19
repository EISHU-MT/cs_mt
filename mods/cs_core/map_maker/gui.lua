function map_maker.show_gui(name)
	local context = map_maker.get_context()
	local mapauthor = context.mapauthor or name
	local status_table = {}
	for name, tabled in pairs(context.status) do
		
		table.insert(status_table, tabled.name or "Unrecognized Area")
	end
	
	local formspec = {
		"formspec_version[6]" ..
		"size[18,11]" ..
		"box[0,0.7;6.6,5.4;#54E616]" ..
		"box[0,0;18.1,0.7;#FF4E4E]" ..
		"label[0.1,0.3;CS:MT MapMaker]" ..
		"field[0.2,1.5;2.8,0.8;posx;X;"..context.center.x.."]" ..
		"field[0.2,2.8;2.8,0.8;posy;Y;"..context.center.y.."]" ..
		"field[0.2,4.1;2.8,0.8;posz;Z;"..context.center.z.."]" ..
		"label[1,1;1. Coordinates / Area for map]" ..
		"button[3.3,1.5;3.1,1.1;set_center;Set Coords\nAs player pos]" ..
		"button[3.3,4.3;1.5,0.6;towe;To WE]" ..
		"button[4.9,4.3;1.5,0.6;fromwe;From WE]" ..
		"button[0.2,5.1;6.2,0.8;emerge;Emerge Area]" ..
		"box[6.6,3.6;5.9,2.5;#FFE500]" ..
		"label[7.2,4;3. Positions for each team]" ..
		"label[6.7,4.6;Status: ]" ..
		"label[8.1,4.6;"..minetest.formspec_escape(map_maker.get_node_status()).."]" ..
		"button[6.8,5.1;5.5,0.8;giveme;Give 2 nodes for each team]" ..
		"box[6.6,0.7;5.9,2.9;#C4FF00]" ..
		"field[6.8,1.4;2.7,0.7;barrier_r;R / Rad;"..context.barrier_r.."]" ..
		"dropdown[9.6,1.4;2.7,0.7;barrier_rot;X=0,Z=0;"..(context.barrier_rot == "x" and 1 or 2)..";false]" ..
		"label[8.2,1;2. Place Barriers]" ..
		"button[6.8,2.7;5.5,0.7;place_barriers;Place Barriers]" ..
		"label[7.6,2.4;This maybe take a while]" ..
		"box[0,6.1;18,4.9;#FF9D00]" ..
		"label[0.2,6.5;5. MetaData / Data for the map]" ..
		"field[5.3,7.5;6.1,0.6;title;Title;"..minetest.formspec_escape(context.maptitle).."]" ..
		"button[0.2,9.3;4.9,1.6;b_bomb;Sector B]" ..
		"label[1.7,7.1;Bomb Areas]" ..
		"field[5.3,8.5;6.1,0.6;name;Technical Name for map;"..minetest.formspec_escape(context.mapname).."]" ..
		"field[11.6,7.5;6.2,0.6;author;Author (Can be multiple names or a group name);"..minetest.formspec_escape(mapauthor).."]" ..
		"button[5.3,10.2;6.1,0.7;close;Close / Countinue making map]" ..
		"button[5.3,9.3;6.1,0.7;export;Export]" ..
		"box[12.5,0.7;5.5,5.4;#FF3100]" ..
		"label[13.3,1;4. Name of areas in map]" ..
		"checkbox[12.7,1.6;enabe_areas;Enable areas names;false]" ..
		"textlist[12.7,2.4;5.1,3.5;;"..table.concat(status_table, ",")..";-1;false]" ..
		"label[14.6,2.1;Areas]" ..
		"button[0.2,7.5;4.9,1.6;a_bomb;Sector A]" ..
		"box[11.6,8.3;6.2,2.5;#00A5FF]" ..
		"label[13.4,8.5;Physics (Optional)]" ..
		"field[11.8,9.1;2.7,0.7;jump;Jump;"..tostring(context.physics.jump).."]" ..
		"field[14.6,9.1;3,0.7;speed;Speed;"..tostring(context.physics.speed).."]" ..
		"field[11.8,10.1;2.7,0.6;gravity;Gravity;"..tostring(context.physics.gravity).."]" ..
		"button[14.6,9.9;3,0.8;save;Save Physics]" ..
		"field[3.3,2.9;3.1,0.5;posr;R;"..context.center.r.."]" ..
		"field[3.3,3.7;3.1,0.5;posh;H;"..context.center.h.."]"
	}

	formspec = table.concat(formspec, "")
	minetest.show_formspec(name, "cs_map:gui", formspec)
end

function map_maker.show_progress_formspec(name, text)
	minetest.show_formspec(name, "cs_map:progress",
		"size[6,1]bgcolor[#080808BB;true]" ..
		default.gui_bg ..
		default.gui_bg_img .. "label[0,0;" ..
		minetest.formspec_escape(text) .. "]")
end

function map_maker.emerge_progress(ctx)
	map_maker.show_progress_formspec(ctx.name,
		string.format("Emerging Area - %d/%d blocks emerged (%.1f%%)",
		ctx.current_blocks, ctx.total_blocks,
		(ctx.current_blocks / ctx.total_blocks) * 100))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "cs_map:gui" then
		return
	end

	local name = player:get_player_name()

	if fields.posx or fields.posy or fields.posz or fields.posh or fields.posr then
		map_maker.set_center(name, {
			x = tonumber(fields.posx),
			y = tonumber(fields.posy),
			z = tonumber(fields.posz),
			h = tonumber(fields.posh),
			r = tonumber(fields.posr)
		})
	end

	if fields.barrier_r then
		map_maker.set_meta("barrier_r", tonumber(fields.barrier_r))
	end

	if fields.title then
		map_maker.set_meta("maptitle", fields.title)
	end

	if fields.author then
		map_maker.set_meta("mapauthor", fields.author)
	end

	if fields.name then
		map_maker.set_meta("mapname", fields.name)
	end

	if fields.initial then
		map_maker.set_meta("mapinitial", fields.initial)
	end

	if fields.barrier_rot then
		map_maker.set_meta("barrier_rot", fields.barrier_rot == "X=0" and "x" or "z")
	end

	if fields.set_center then
		map_maker.set_center(name)
	end

	if fields.giveme then
		player:get_inventory():add_item("main", "cs_core:terrorists")
		player:get_inventory():add_item("main", "cs_core:counters")
	end

	if fields.emerge then
		map_maker.emerge(name)
	end

	if fields.place_barriers then
		map_maker.place_barriers(name)
	end

	if fields.towe then
		map_maker.we_select(name)
	end

	if fields.fromwe then
		map_maker.we_import(name)
	end

	if fields.save then
		local tabled = {
			jump = tonumber(fields.jump) or 1,
			speed = tonumber(fields.speed) or 1,
			gravity = tonumber(fields.gravity) or 1,
		}
		local src = core.serialize(tabled)
		map_maker.set_meta("physics", src)
	end

	if fields.a_bomb then
		map_maker.put_a_bomb(player)
	end

	if fields.b_bomb then
		map_maker.put_b_bomb(player)
	end

	if fields.export then
		map_maker.export(name)
	end

	if not fields.quit then
		map_maker.show_gui(name)
	end
end)

minetest.register_chatcommand("gui", {
	func = function(name)
		map_maker.show_gui(name)
		return true
	end
})
