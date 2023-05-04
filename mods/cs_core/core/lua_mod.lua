local enable_debug = minetest.settings:get_bool("cs_core.enable_env_debug", false)
local getinfo, rawget, rawset = debug.getinfo, rawget, rawset

local dec = {}
local meta = {}

function meta:__newindex(name, value)
	rawset(self, name, value)
	if enable_debug then
		if dec[name] then
			core.log("action", "Setting new value at "..tostring(self).."; name= "..name..", contents= "..tostring(value).."| Undeclared!!")
		end
	end
end

function empty() end

function meta:__index(name)
end

local value2
function Declare(name, value)
	assert(name)
	if value == false or value == nil then
		value2 = true
	else
		value2 = value
	end
	assert(value2)
	dec[name] = true
	_G[name] = value or value2
	if enable_debug then
		core.log("action", "Setting new value at "..tostring(self or "_G").."; name= "..name..", contents= "..tostring(value))
	end
end

setmetatable(_G, meta)