--Positional variables
local X = -218
local Y = 170
local YGAP = 38
local XGAP = 87

local TITLE_Y_OFFSET = 30

local ORDERS =
{
    {"silk",           { -218, Y+TITLE_Y_OFFSET}},
    {"needle",         { -70, Y+TITLE_Y_OFFSET}},
    {"charms",           { 90, Y+TITLE_Y_OFFSET}},
    {"allegiance",      { 200, Y+TITLE_Y_OFFSET}}, --void and soul?
}

local function BuildSkillsData(SkillTreeFns)
    local skills =
    {
        --Silk
        hornet_silk_capacity_1 = {
            title = "Silk Test",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_1",
            pos = {X,Y},
            group = "silk",
            tags = {"hornet_silk"},
            root = true,
            connects = {
                "hornet_silk_capacity_2",
            },
        },
        hornet_silk_capacity_2 = {
            title = "Silk Test 2",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_2",
            pos = {X,Y-YGAP},
            group = "silk",
            tags = {"hornet_silk"},
            connects = {
                "hornet_silk_capacity_3",
            },
        },
        hornet_silk_capacity_3 = {
            title = "Silk Test 3",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_2",
            pos = {X,Y-YGAP*2},
            group = "silk",
            tags = {"hornet_silk"},
        },

         --Needle
         hornet_needle_damage_1 = {
            title = "needle Test",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_1",
            pos = {X + XGAP,Y},
            group = "needle",
            tags = {"hornet_needle"},
            root = true,
            connects = {
                "hornet_silk_capacity_2",
            },
        },

        --charms
        hornet_charm_1 = {
            title = "needle Test",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_1",
            pos = {X + XGAP*2,Y},
            group = "charms",
            tags = {"hornet_charm"},
            root = true,
            connects = {
                "hornet_silk_capacity_2",
            },
        },
        --Affinity
        hornet_void_1 = {
            title = "needle Test",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_1",
            pos = {X + XGAP*3,Y},
            group = "allegiance",
            tags = {"hornet_charm"},
            root = true,
            connects = {
                "hornet_silk_capacity_2",
            },
        },
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

--------------------------------------------------------------------------------------------------

return BuildSkillsData