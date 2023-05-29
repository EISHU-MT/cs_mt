local response = minetest.settings:get_bool("cs_map.mapmaking", false)
ppng = "knife.png"
cpng = "chand.png"
if not response then
    caps = {times = {[1]=500.99, [2]=500.99, [3]=500.99}, uses = 0, maxlevel = 1}
    dug =  {times = {[2] = 500.99, [3] = 500.99,}, uses = 0, maxlevel = 1}
    range = 2
    --wim = ppng
    minetest.override_item("", {
        range = range,
        wield_image = "knife.png",
        --wield_scale = {x=1,y=1,z=2.5},
        tool_capabilities = {
            full_punch_interval = 0.5,
            max_drop_level = 0,
            groupcaps = {
                crumbly = caps,
                cracky  = caps,
                snappy  = caps,
                choppy  = caps,
                oddly_breakable_by_hand = caps,
                -- dig_immediate group doesn't use value 1. Value 3 is instant dig
                dig_immediate = dug,
            },
            damage_groups = {fleshy = 10},
        }
    })
else
    caps = {times = {[1]=34, [2]=34, [3]=34}, uses = 0, maxlevel = 256}
    dug =  {times = {[2] = 34, [3] = 0,}, uses = 0, maxlevel = 256}
    range = 20
    minetest.override_item("", {
        range = range,
        wield_image = "hand.png",
        --wield_scale = {x=1,y=1,z=2.5},
        tool_capabilities = {
            full_punch_interval = 0.5,
            max_drop_level = 0,
            groupcaps = {
                crumbly = caps,
                cracky  = caps,
                snappy  = caps,
                choppy  = caps,
                oddly_breakable_by_hand = caps,
                -- dig_immediate group doesn't use value 1. Value 3 is instant dig
                dig_immediate = dug,
            },
            damage_groups = {fleshy = 10},
        }
    })
end


