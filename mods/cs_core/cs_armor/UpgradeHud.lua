function armor.upgrade_hud_armor(player)
	local value = armor.get_value(player)
	local value2 = 100
	--[[if value > 10 and value < 20 then
		hb.change_hudbar(player, "armor", math.min(value, value2), value2, "cs_files_armor_iconHI.png")
		return
	end
	if value > 20 and value < 50 then
		hb.change_hudbar(player, "armor", math.min(value, value2), value2, "cs_files_armor_iconMED.png")
		return
	end
	if value > 50 and value < 100 then
		hb.change_hudbar(player, "armor", math.min(value, value2), value2, "cs_files_armor_icon.png")
		return
	end--]]
	if value == 20 then --inversor
		val = 100
	elseif value == 21 then
		val = 99
	elseif value == 22 then
		val = 98
	elseif value == 23 then
		val = 97
	elseif value == 24 then
		val = 96
	elseif value == 25 then
		val = 95
	elseif value == 26 then
		val = 93
	elseif value == 27 then
		val = 92
	elseif value == 28 then
		val = 90
	elseif value == 29 then
		val = 89
	elseif value == 30 then
		val = 88
	elseif value == 31 then
		val = 87
	elseif value == 32 then
		val = 86
	elseif value == 33 then
		val = 85
	elseif value == 34 then
		val = 84
	elseif value == 35 then
		val = 83
	elseif value == 36 then
		val = 81
	elseif value == 37 then
		val = 80
	elseif value == 38 then
		val = 79
	elseif value == 39 then
		val = 75
	elseif value == 40 then
		val = 74
	elseif value == 41 then
		val = 73
	elseif value == 42 then
		val = 72
	elseif value == 43 then
		val = 71
	elseif value == 44 then
		val = 70
	elseif value == 45 then
		val = 69
	elseif value == 46 then
		val = 68
	elseif value == 47 then
		val = 67
	elseif value == 48 then
		val = 66
	elseif value == 49 then
		val = 65
	elseif value == 50 then
		val = 64
	elseif value == 51 then
		val = 63
	elseif value == 52 then
		val = 62
	elseif value == 53 then
		val = 61
	elseif value == 54 then
		val = 60
	elseif value == 55 then
		val = 59
	elseif value == 56 then
		val = 58
	elseif value == 57 then
		val = 57
	elseif value == 58 then
		val = 56
	elseif value == 59 then
		val = 55
	elseif value == 60 then
		val = 54
	elseif value == 61 then
		val = 53
	elseif value == 62 then
		val = 52
	elseif value == 63 then
		val = 51
	elseif value == 64 then
		val = 50
	elseif value == 65 then
		val = 49
	elseif value == 66 then
		val = 45
	elseif value == 67 then
		val = 44
	elseif value == 68 then
		val = 43
	elseif value == 69 then
		val = 42
	elseif value == 70 then
		val = 41
	elseif value == 71 then
		val = 40
	elseif value == 72 then
		val = 39
	elseif value == 73 then
		val = 38
	elseif value == 74 then
		val = 37
	elseif value == 75 then
		val = 36
	elseif value == 76 then
		val = 35
	elseif value == 77 then
		val = 34
	elseif value == 78 then
		val = 33
	elseif value == 79 then
		val = 32
	elseif value == 80 then
		val = 31
	elseif value == 81 then
		val = 30
	elseif value == 82 then
		val = 29
	elseif value == 83 then
		val = 28
	elseif value == 84 then
		val = 27
	elseif value == 85 then
		val = 26
	elseif value == 86 then
		val = 25
	elseif value == 87 then
		val = 24
	elseif value == 88 then
		val = 23
	elseif value == 89 then
		val = 23
	elseif value == 90 then
		val = 23
	elseif value == 91 then
		val = 24
	elseif value == 92 then
		val = 23
	elseif value == 93 then
		val = 22
	elseif value == 94 then
		val = 21
	elseif value == 95 then
		val = 20
	elseif value == 96 then
		val = 20
	elseif value == 97 then
		val = 21
	elseif value == 98 then
		val = 21
	elseif value == 99 then
		val = 21
	elseif value == 100 then
		val = 21
	elseif value == 101 then
		val = 20
	elseif value == 102 then
		val = 20
	elseif value == 103 then
		val = 19
	elseif value == 104 then
		val = 18
	elseif value == 105 then
		val = 17
	elseif value == 106 then
		val = 16
	elseif value == 107 then
		val = 15
	elseif value == 108 then
		val = 14
	elseif value == 109 then
		val = 13
	elseif value == 110 then
		val = 12
	elseif value == 111 then
		val = 11
	elseif value == 112 then
		val = 10
	elseif value == 113 then
		val = 9
	elseif value == 114 then
		val = 8
	elseif value == 115 then
		val = 7
	elseif value == 116 then
		val = 2.5
	elseif value == 117 then
		val = 1
	elseif value == 118 then
		val = 0
	elseif value == 119 then
		val = 0
	elseif value == 120 then
		val = 0
	end
	if not tonumber(val) then
		val = 70
	end
	hb.change_hudbar(player, "armor", val, value2)
end


upgrade = armor.upgrade_hud_armor
--upgrade_all()
