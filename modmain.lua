PrefabFiles = {
	"hornet",
	"hornet_none",
	"hneedle1",
	--"hneedle2",
	--"hneedle3",
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
}

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

AddMinimapAtlas("images/map_icons/hornet.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

--local RECIPETABS = GLOBAL.RECIPETABS
--local Ingredient = GLOBAL.Ingredient
--local Recipe = GLOBAL.Recipe
--local TECH = GLOBAL.TECH
-- Enable these when coded for and needed

-- The character select screen lines
STRINGS.CHARACTER_TITLES.hornet = "The Sentinel"
STRINGS.CHARACTER_NAMES.hornet = "Hornet"
STRINGS.CHARACTER_DESCRIPTIONS.hornet = "*Possesses a weaponised Needle\n*Moves Fast\n*Is suprisingly sane"
STRINGS.CHARACTER_QUOTES.hornet = "\"No shadow will haunt me...\""
STRINGS.CHARACTER_SURVIVABILITY.hornet = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.HORNET = require "speech_hornet"

--This could be interesting to do...
--STRINGS.CHARACTERS.GENERIC.DESCRIBE.MABEL = 
--{
	--GENERIC = "What A Cute Girl!",
	--ATTACKER = "Do I Look Like Bill?",
	--MURDERER = "What Have You Done...",
	--REVIVER = "Thank You!",
	--GHOST = "A Glittery Ghost!",
--}


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

TUNING.STARTING_ITEM_IMAGE_OVERRIDE.hneedle1 = {atlas = "images/inventoryimages/hneedle1.xml", image = "hneedle1.tex" }

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("hornet", "FEMALE", skin_modes)

--Item stuff
STRINGS.NAMES.HNEEDLE1 = "Damaged Needle"
--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.HNEEDLE1 = ""
--GLOBAL.STRINGS.CHARACTERS.HORNET.DESCRIBE.HNEEDLE1 = ""

--Recipe("hneedle1", {Ingredient("flint", 1), Ingredient("marble", 1), Ingredient("silk", 4)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil, "ishornet")
--Recipe("hneedle2", {Ingredient("flint", 1), Ingredient("marble", 2), Ingredient("silk", 6)}, RECIPETABS.WAR, TECH.SCIENCE_TWO, nil, nil, nil, nil, "ishornet")
--Recipe("hneedle3", {Ingredient("flint", 1), Ingredient("marble", 3), Ingredient("silk", 8)}, RECIPETABS.WAR, TECH.MAGIC_THREE, nil, nil, nil, nil, "ishornet")
