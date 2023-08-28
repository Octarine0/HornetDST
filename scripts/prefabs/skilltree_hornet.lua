local ORDERS =
{
    {"silk",           { -214+18   , 176 + 30 }},
    {"needle",         { -62       , 176 + 30 }},
    {"charms",           { 66+18     , 176 + 30 }},
    {"allegiance",      { 204       , 176 + 30 }}, --void and essence?
}

local function BuildSkillsData(SkillTreeFns)
    local skills = 
    {
        
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

--------------------------------------------------------------------------------------------------

return BuildSkillsData