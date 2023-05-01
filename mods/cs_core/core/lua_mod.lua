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

function Declare(name, value)
	assert(name)
	assert(value)
	dec[name] = true
	_G[name] = value
	if enable_debug then
		core.log("action", "Setting new value at "..tostring(self or "_G").."; name= "..name..", contents= "..tostring(value))
	end
end

setmetatable(_G, meta)