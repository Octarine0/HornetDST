--Positional variables
local X = -218
local Y = 176
local YGAP = 38
local XGAP = 87

local TITLE_Y_OFFSET = 30

local ORDERS =
{
    {"silk",           { -214+18   , Y+TITLE_Y_OFFSET}},
    {"needle",         { -62       , Y+TITLE_Y_OFFSET}},
    {"charms",           { 66+18     , Y+TITLE_Y_OFFSET}},
    {"allegiance",      { 204       , Y+TITLE_Y_OFFSET}}, --void and soul?
}

local function BuildSkillsData(SkillTreeFns)
    local skills = 
    {
        hornet_silk_1 = {
            title = "Silk Test",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_1",
            pos = {X,Y},
            group = "silk",
            tags = {"hornet_silk"},
            root = true,
            connects = {
                "hornet_silk_2",
            },
        },
        hornet_silk_2 = {
            title = "Silk Test 2",
            desc = "Just a test for now",
            icon = "wolfgang_critwork_2",
            pos = {X,Y},
            group = "silk",
            tags = {"hornet_silk"},
        },

    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

--------------------------------------------------------------------------------------------------

return BuildSkillsData