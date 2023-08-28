PrefabFiles = {
	"hornet",
	"hornet_none",
	"hneedle1",
	"hneedle2",
	"hneedle3",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/hornet.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/hornet.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/hornet.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/hornet.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/hornet_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/hornet_silho.xml" ),

    Asset( "IMAGE", "bigportraits/hornet.tex" ),
    Asset( "ATLAS", "bigportraits/hornet.xml" ),
	
	Asset( "IMAGE", "images/map_icons/hornet.tex" ),
	Asset( "ATLAS", "images/map_icons/hornet.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_hornet.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_hornet.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_hornet.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_hornet.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_hornet.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_hornet.xml" ),
	
	Asset( "IMAGE", "images/names_hornet.tex" ),
    Asset( "ATLAS", "images/names_hornet.xml" ),
	
	Asset( "IMAGE", "images/names_gold_hornet.tex" ),
    Asset( "ATLAS", "images/names_gold_hornet.xml" ),
	
	Asset("FONT", "fonts/talkingfont_hornet.zip"),
	
	Asset("SCRIPT", "scripts/prefabs/skilltree_hornet.lua"),
}

local SkillTreeDefs = require("prefabs/skilltree_defs")
GLOBAL.TALKINGFONT_HORNET = "talkingfont_hornet"

AddSimPostInit(function()
	GLOBAL.TheSim:UnloadFont(GLOBAL.TALKINGFONT_HORNET)
	GLOBAL.TheSim:UnloadPrefabs({"hornet_fonts"})

	local Assets = {
		Asset("FONT", GLOBAL.resolvefilepath("fonts/talkingfont_hornet.zip")),
	}
	local FontsPrefab = GLOBAL.Prefab("hornet_fonts", function() return _G.CreateEntity() end, Assets)
	
	GLOBAL.RegisterPrefabs(FontsPrefab)
	GLOBAL.TheSim:LoadPrefabs({"hornet_fonts"})
	
	GLOBAL.TheSim:LoadFont(GLOBAL.resolvefilepath("fonts/talkingfont_hornet.zip"), GLOBAL.TALKINGFONT_HORNET)
end)

--Hollow knight mod compat
local HollowKnightPresent = false

if GLOBAL.TheNet:GetIsClient() then
	local EnabledServerMods = GLOBAL.TheNet:GetServerModNames()
	for k, v in pairs(EnabledServerMods) do
		if v == "workshop-1364606782" then
			HollowKnightPresent = true
		end
	end
end

if GLOBAL.KnownModIndex then
	if GLOBAL.KnownModIndex:IsModEnabled("workshop-1364606782") then
		HollowKnightPresent = true
	end
end

--Test string
if HollowKnightPresent then
	print("Hornet mod - Hollow Knight mod compat enabled")
end

--End of Hollow knight mod compat check

AddMinimapAtlas("images/map_icons/hornet.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.hornet = "The Sentinel"
STRINGS.CHARACTER_NAMES.hornet = "Hornet"
STRINGS.CHARACTER_DESCRIPTIONS.hornet = "*Possesses a weaponised Needle\n*Moves Fast\n*Is suprisingly sane"
STRINGS.CHARACTER_QUOTES.hornet = "\"No shadow will haunt me...\""
STRINGS.CHARACTER_SURVIVABILITY.hornet = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.HORNET = require "speech_hornet"

--Would allow me to tidy this all up a bit and move the description stuff
--modimport("scripts/descriptions_hornet.lua")

--Probably works maybe?
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HORNET = 
{
	GENERIC = "That mask's kind of creepy.",
	ATTACKER = "I don't like the way they're holding that needle...",
	MURDERER = "Murderer!",
	REVIVER = "Maybe %s isn't completely cold.",
	GHOST = "A lost soul.",
}

STRINGS.CHARACTERS.WILLOW.DESCRIBE.HORNET = --Maybe works? 
{
	GENERIC = "Test String 1 from willow.",
	ATTACKER = "Test String Attack from willow.",
	MURDERER = "Test String murder from willow.",
	REVIVER = "%s reignited my flame.",
	GHOST = "Test String Ghost from willow.",
}

--Hollow knight mod examine text cross compat
if HollowKnightPresent then
	STRINGS.CHARACTERS.HORNET.DESCRIBE.HOLLOWKNIGHT =
	{
		GENERIC = "Again we meet little ghost.",
		ATTACKER = "Come no closer, ghost.",
		MURDERER = "I will not stand idle little ghost. Your actions must be stopped.",
		REVIVER = "Once again you give me hope little ghost.",
		GHOST = "You were born of the abyss. Now it seems you have returned to it.",
	}
end


-- The character's name as appears in-game 
STRINGS.NAMES.HORNET = "Hornet"
STRINGS.SKIN_NAMES.hornet_none = "Hornet"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Needed because programming is weird like that. Otherwise the item would be invisible
TUNING.STARTING_ITEM_IMAGE_OVERRIDE.hneedle1 = {atlas = "images/inventoryimages/hneedle1.xml", image = "hneedle1.tex" }

--SkillTree
local CreateSkillTree = function()
	--print("Skilltree gen for Hornet")
	local BuildSkillsData = require("prefabs/skilltree_hornet") -- Load in the skilltree

    if BuildSkillsData then
        local data = BuildSkillsData(SkillTreeDefs.FN)

        if data then
            SkillTreeDefs.CreateSkillTreeFor("hornet", data.SKILLS)
            SkillTreeDefs.SKILLTREE_ORDERS["hornet"] = data.ORDERS
			--print("Skilltree generated for Hornet.")
        end
    end
end
CreateSkillTree();

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("hornet", "FEMALE", skin_modes)

--Item stuff
STRINGS.NAMES.HNEEDLE1 = "Damaged Needle"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HNEEDLE1 = "Looks like a giant needle. Not sure what I'd use it for..."
GLOBAL.STRINGS.CHARACTERS.HORNET.DESCRIBE.HNEEDLE1 = "Damaged, but still functional"

STRINGS.NAMES.HNEEDLE2 = "Repaired Needle"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HNEEDLE2 = "A giant needle. Not sure what I'd use it for..."
GLOBAL.STRINGS.CHARACTERS.HORNET.DESCRIBE.HNEEDLE2 = "Repaired, but not what it was."

STRINGS.NAMES.HNEEDLE3 = "Restored Needle"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HNEEDLE3 = "A giant needle. Beautiful, but useless..."
GLOBAL.STRINGS.CHARACTERS.HORNET.DESCRIBE.HNEEDLE3 = "Restored to it's former glory."

--Recipes
local RECIPETABS = GLOBAL.RECIPETABS
local Ingredient = GLOBAL.Ingredient
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

Recipe("hneedle1", {Ingredient("flint", 1), Ingredient("marble", 1), Ingredient("silk", 4)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil, "ishornet", "images/inventoryimages/hneedle1.xml", "hneedle1.tex")
Recipe("hneedle2", {Ingredient("flint", 1), Ingredient("marble", 2), Ingredient("silk", 6)}, RECIPETABS.WAR, TECH.SCIENCE_TWO, nil, nil, nil, nil, "ishornet", "images/inventoryimages/hneedle2.xml", "hneedle2.tex")
Recipe("hneedle3", {Ingredient("flint", 1), Ingredient("marble", 3), Ingredient("silk", 8)}, RECIPETABS.WAR, TECH.MAGIC_THREE, nil, nil, nil, nil, "ishornet", "images/inventoryimages/hneedle2.xml", "hneedle2.tex")