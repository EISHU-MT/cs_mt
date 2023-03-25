local c_ind_stone      = minetest.get_content_id("cs_map:stone")
local c_ind_stone_red  = minetest.get_content_id("air")
local c_ind_glass      = minetest.get_content_id("cs_map:ind_glass")
local c_ind_glass_red  = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_water      = minetest.get_content_id("default:water_source")
local c_air        = minetest.get_content_id("air")




-- Returns the appropriate barrier node depending on the existing node
local function get_barrier_node(c_id)
	-- If existing node is air/ind. glass/CTF ignore, return ind. glass
	-- Else return ind. stone
	if c_id == c_air or c_id == c_ind_glass or c_id == c_ignore then
		return c_ind_glass
	else
		return c_ind_stone
	end
end

function cs_map.place_outer_barrier(center, r, h)
print("hologram5")
	local minp = vector.subtract(center, r)
	print("hologram6")
	local maxp = vector.add(center, r)
	print("hologram7")
	minp.y = center.y - h / 2
	maxp.y = center.y + h / 2

	minetest.log("action", "Map maker: Loading data into LVM")

	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local a = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	local data = vm:get_data()

	-- Left
	minetest.log("action", "Map maker: Placing left wall")
	do
		local x = center.x - r
		for z = minp.z, maxp.z do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end

	-- Right
	minetest.log("action", "Map maker: Placing right wall")
	do
		local x = center.x + r
		for z = minp.z, maxp.z do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end

	-- Front
	minetest.log("action", "Map maker: Placing front wall")
	do
		local z = center.z - r
		for x = minp.x, maxp.x do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end

	-- Back
	minetest.log("action", "Map maker: Placing back wall")
	do
		local z = center.z + r
		for x = minp.x, maxp.x do
			for y = minp.y, maxp.y do
				local vi = a:index(x, y, z)
				data[vi] = get_barrier_node(data[vi])
			end
		end
	end

	-- Bedrock
	minetest.log("action", "Map maker: Placing bedrock")
	do
		local y = minp.y
		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				data[a:index(x, y, z)] = c_ind_stone
			end
		end
	end

	-- Ceiling
	minetest.log("action", "Map maker: Placing ceiling")
	do
		local y = maxp.y
		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				data[a:index(x, y, z)] = c_ind_glass
			end
		end
	end

	minetest.log("action", "Map maker: Writing to engine!")

	vm:set_data(data)
	vm:write_to_map(data)
	vm:update_map()
end


