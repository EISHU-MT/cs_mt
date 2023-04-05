clua.cs_decor = {}
function clua.cs_decor.scripter() return false end
function clua.cs_decor.dofiles() return true end
clua.cs_decor.name = "CS:MT Decor"
clua.register_table("cs_decor", {
	radious = 1,
	clua_loaded = true,
})