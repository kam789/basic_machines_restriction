minetest.register_privilege("bmachines",
    { description = "Able to use all basic_machines.", give_to_singleplayer = false })

-- listed nodes require bmachines priv for placement
-- to add additional nodes, insert new entries into machine_list

local machine_list = {
    "basic_machines:autocrafter",
    "basic_machines:battery_0",
    "basic_machines:battery_1",
    "basic_machines:battery_2",
    "basic_machines:clockgen",
    "basic_machines:constructor",
    "basic_machines:detector",
    "basic_machines:distributor",
    "basic_machines:enviro",
    "basic_machines:generator",
    "basic_machines:grinder",
    "basic_machines:keypad",
    "basic_machines:light_off",
    "basic_machines:light_on",
    "basic_machines:mover",
    "basic_machines:recycler",
    "basic_machines:ball_spawner",
}

minetest.register_on_mods_loaded(function()
    for machinecount = 1, #machine_list do
        if minetest.registered_items[machine_list[machinecount]] then
            minetest.override_item(machine_list[machinecount], {
                on_place = function(itemstack, placer, pointed_thing)
                    local can_mess = minetest.check_player_privs(placer.get_player_name(placer), { bmmachines = true })
                    if not can_mess then
                        minetest.chat_send_player(placer:get_player_name(), "Insufficient privs, you're not allowed to use this.")
                        return
                    end
                    return minetest.item_place(itemstack, placer, pointed_thing)
                end
            })
        end
    end
end)
