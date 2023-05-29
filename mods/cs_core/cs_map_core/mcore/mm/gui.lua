function return_formspec(rad_msg, wand_name)
	local form = {
	"formspec_version[6]" ..
	"size[10.5,6]" ..
	"box[0,0;12.4,0.8;#009200]" ..
	"label[4.9,0.4;"..tostring(wand_name or "").." ".."Areas.]" ..
	"field[0.2,1.3;10.1,1;str;Please set a name to this area.;Eg: Sector A]" ..
	"field[0.2,2.8;10.1,1;rad;Radius of this area.;"..tostring(rad_msg or "Eg: 10, (Optional)").."]" ..
	"button_exit[0.1,4;10.3,0.8;decline;Cancel]" ..
	"button_exit[0.1,5;10.3,0.8;accept;Accept]"
	}
	return table.concat(form, "")
end

function wand_formspec(pos1, pos2)
	return "formspec_version[6]" ..
	"size[10.5,4]" ..
	"box[-0.1,1;10.6,2;#6ABBE8]" ..
	"box[0,0;10.5,1;#00FFFF]" ..
	"label[0.4,0.5;Wand Menu]" ..
	"label[0.4,2;Pos 1: "..tostring(pos1 or "<non set>").."]" ..
	"label[0.4,2.6;Pos 2: "..tostring(pos2 or "<non set>").."]" ..
	"label[0.4,1.4;Positions]" ..
	"box[0,3;10.6,1;#D40505]" ..
	"button[0.1,3.1;5.1,0.8;reset;Reset positions]" ..
	"button_exit[5.3,3.1;5.1,0.8;close;Close]"
end

function show_gui(name)
	local context = return_context()
	local mapauthor = context.mapauthor or name
	local status_table = {}
	for name, tabled in pairs(context.areas) do
		table.insert(status_table, tabled.name or "Unrecognized Area")
	end
	
	print(dump(context))
	
	local formspec = 
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
		"label[8.1,4.6;"..minetest.formspec_escape(get_node_status()).."]" ..
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
		"field[3.3,2.9;3.1,0.5;posr;R;"..tostring(context.center.r).."]" ..
		"field[3.3,3.7;3.1,0.5;posh;H;"..tostring(context.center.h).."]" ..
		"button[0.2,7.5;4.9,1.6;a_bomb;Sector A]" ..
		"box[11.6,8.3;6.2,2.5;#00A5FF]" ..
		"label[13.4,8.5;Physics (Optional)]" ..
		"field[11.8,9.1;2.7,0.7;jump;Jump;"..tostring(context.physics.jump).."]" ..
		"field[14.6,9.1;3,0.7;speed;Speed;"..tostring(context.physics.speed).."]" ..
		"field[11.8,10.1;2.7,0.6;gravity;Gravity;"..tostring(context.physics.gravity).."]" ..
		"button[14.6,9.9;3,0.8;save;Save Physics]"
		
	minetest.show_formspec(name, "map_maker:gui", formspec)
end

function show_progress_formspec(name, text)
	minetest.show_formspec(name, "map_maker:progress",
		"size[6,1]bgcolor[#080808BB;true]" ..
		default.gui_bg ..
		default.gui_bg_img .. "label[0,0;" ..
		minetest.formspec_escape(text) .. "]")
end

function emerge_progress(ctx)
	show_progress_formspec(ctx.name,
		string.format("Emerging Area - %d/%d blocks emerged (%.1f%%)",
		ctx.current_blocks, ctx.total_blocks,
		(ctx.current_blocks / ctx.total_blocks) * 100))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "map_maker:gui" then
		return
	end

	local name = player:get_player_name()

	if fields.posx or fields.posy or fields.posz or fields.posh or fields.posr then
		set_center(name, {
			x = tonumber(fields.posx),
			y = tonumber(fields.posy),
			z = tonumber(fields.posz),
			h = tonumber(fields.posh),
			r = tonumber(fields.posr)
		})
	end

	if fields.barrier_r then
		set_meta("barrier_r", tonumber(fields.barrier_r))
	end

	if fields.title then		set_meta("maptitle", fields.title)
	end

	if fields.author then
		set_meta("mapauthor", fields.author)
	end

	if fields.name then
		set_meta("mapname", fields.name)
	end

	if fields.initial then
		set_meta("mapinitial", fields.initial)
	end

	if fields.barrier_rot then
		set_meta("barrier_rot", fields.barrier_rot == "X=0" and "x" or "z")
	end

	if fields.set_center then
		set_center(name)
	end

	if fields.giveme then
		player:get_inventory():add_item("main", "mcore:terrorists")
		player:get_inventory():add_item("main", "mcore:counters")
	end

	if fields.emerge then
		emerge(name)
	end

	if fields.place_barriers then
		place_barriers(name)
	end

	if fields.towe then
		we_select(name)
	end

	if fields.fromwe then
		we_import(name)
	end

	if fields.save then
		local tabled = {
			jump = tonumber(fields.jump) or 1,
			speed = tonumber(fields.speed) or 1,
			gravity = tonumber(fields.gravity) or 1,
		}
		local src = core.serialize(tabled)
		set_meta("physics", src)
	end

	if fields.a_bomb then
		put_a_bomb(player)
	end

	if fields.b_bomb then
		put_b_bomb(player)
	end

	if fields.export then
		export(name)
	end

	if not fields.quit then
		show_gui(name)
	end
end)

minetest.register_chatcommand("gui", {
	func = function(name)
		show_gui(name)
		return true
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "mm:areas" or formname ~= "mm:wand" or formname ~= "mm:wand1" then
		return
	end
	if formname == "mm:areas" then
		if fields.accept and (fields.str ~= "Eg: Sector A" or fields.str ~= " " or fields.str ~= "") then
			local pos = area_status[Name(player)].position
			local name = replace_spaces(fields.str)
			context.status[name] = {position = vector.new(pos), name = fields.str, rad = tonumber(fields.rad) or 10, nonradius = false}
			storage:set_string("status", core.serialize(context.status))
			area_status[Name(player)] = nil
			core.set_node(pos, {name="air"})
				local ent = minetest.add_entity(pos, "mcore:display")
				local r = ent:get_properties()
				local rad = tonumber(fields.rad) or 10
				r.visual_size = {x = rad, y = rad},
				ent:set_properties(r)
		elseif fields.decline then
			core.chat_send_player(Name(player), core.colorize("#FF0000", "Declined."))
			local pos = area_status[Name(player)].position
			core.set_node(pos, {name="air"})
			area_status[Name(player)] = nil
		end
	elseif formname == "mm:wand" then
		if fields.reset then
			wand[Name(player)] = {pos1 = {}, pos2 = {}}
			for _, pos in pairs(wand_nodes) do
				core.set_node(pos, {name="air"})
			end
			wand_nodes = {}
		end
	elseif formname == "mm:wand1" then
		if fields.accept and (fields.str ~= "Eg: Sector A" or fields.str ~= " " or fields.str ~= "") then
			local pos1 = wand[Name(player)].pos1
			local pos2 = wand[Name(player)].pos2
			if pos1 and pos2 then
				local name = replace_spaces(fields.str)
				local dist = vector.distance(pos1, pos2)
				if not dist >= 100 then
					context.status[name] = {positions = {pos1 = pos1, pos2 = pos2}, name = fields.str, nonradius = true}
					for _, pos in pairs(wand_nodes) do
						core.set_node(pos, {name="air"})
					end
					wand_nodes = {}
				end
			end
		elseif fields.decline then
			core.chat_send_player(Name(player), core.colorize("#FF0000", "Declined."))
			wand[Name(player)] = nil
			for _, pos in pairs(wand_nodes) do
				core.set_node(pos, {name="air"})
			end
			wand_nodes = {}
		end
	end
end)