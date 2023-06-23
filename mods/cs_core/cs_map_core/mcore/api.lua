function maps.register_map(map_name, def)
	if map_name and def and type(map_name) == "string" and type(def) == "table" then
		data = table.copy(def)
		data.meta = Settings(def.dirname.."/map.cfg")
		if not def.name then
			data.name = map_name
		end
		local map = process_meta(data)
		
		if map.failed ~= true then
			maps.reg_maps[map_name or data.name] = map
			if arapi_is_loaded then
				if map.bots_areas then
					arapi.reload_all_areas(map)
				end
			end
			maps.update_core()
		else
			core.log("error", "Seems like the map '"..map_name.."' had incorrect definition or something failed")
		end
	end
end

function maps.register_on_load(func)
	table.insert(maps.on_load, func or function() end)
end