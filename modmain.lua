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
	
	Asset( "IMAGE", "images/hornet_skilltree.tex" ),
    Asset( "ATLAS", "images/hornet_skilltree.xml" ),
	Asset( "SCRIPT", "scripts/prefabs/skilltree_hornet.lua"),
}

local SkillTreeDefs = require("prefabs/skilltree_defs")
GLOBAL.TALKINGFONT_HORNET = "talkingfont_hornet"
--silkBadge = require "widgets/silkbadge" --for the silk meter

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

STRINGS.CHARACTERS.WILLOW.DESCRIBE.HORNET = --Seems to work... probably? 
{
	GENERIC = "Hi %s!",
	ATTACKER = "You seem a little prickly today %s.",
	MURDERER = "Prepare for imolation murderer.", --this needs changed, but for now
	REVIVER = "%s reignited my flame.",
	GHOST = "Ghosts don't catch well... Better get a heart.",
	FIRESTARTER = "Get that fire started %s.",
}

--TUNING.HORNET_CHARM = GetModConfigData("HORNET_CHARM")

--Hollow knight mod examine text cross compat
if HollowKnightPresent then
	STRINGS.CHARACTERS.HORNET.DESCRIBE.HOLLOWKNIGHT = --all this may not be required. The new speech file may do it already.
	{
		GENERIC = "Again we meet little ghost.",
		ATTACKER = "Come no closer, ghost.",
		MURDERER = "I will not stand idle little ghost. Your actions must be stopped.",
		REVIVER = "Once again you give me hope little ghost.",
		GHOST = "You were born of the abyss. Now it seems you have returned to it.",
		FIRESTARTER = "Get that fire started %s.",
	},
	--STRINGS.CHARACTERS.HOLLOWKNIGHT.DESCRIBE.HORNET = -- all this code doesn't work. Priority registering issue I think. Not sure. Will look in to. Maybe add post init?
	--{
		--GENERIC = "...",
		--ATTACKER = "...",
		--MURDERER = "...",
		--REVIVER = "...",
		--GHOST = "...",
		--FIRESTARTER = "...",
	--},
	--if TUNING.HORNET_CHARM == "crenabled" or "enabled" then
		--Maybe add the ability to use h knight charms? Would need to add the slot...
	--end
	print("Hornet Got this far")
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
local OldGetSkilltreeBG = GLOBAL.GetSkilltreeBG
function GLOBAL.GetSkilltreeBG(imagename, ...)
    if imagename == "hornet_background.tex" then
        return "images/hornet_skilltree.xml"
    else
        return OldGetSkilltreeBG(imagename, ...)
    end
end

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

--silk meter 

local silkbadge  = require "widgets/silkbadge"
AddClassPostConstruct("widgets/statusdisplays", function(self)
	if self.owner.prefab ~= 'hornet' then
		return
	end

	self.name = self:AddChild(silkbadge(self.owner))
	self.name:SetPosition(62, 35, 0)
end)

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

Recipe("hneedle1", {Ingredient("marble", 1), Ingredient("silk", 6)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil, "ishornet", "images/inventoryimages/hneedle1.xml", "hneedle1.tex")
Recipe("hneedle2", {Ingredient("hneedle1", 1), Ingredient("marble", 10), Ingredient("silk", 10)}, RECIPETABS.WAR, TECH.SCIENCE_TWO, nil, nil, nil, nil, "ishornet", "images/inventoryimages/hneedle2.xml", "hneedle2.tex")
Recipe("hneedle3", {Ingredient("hneedle2", 1), Ingredient("spiderhat", 1), Ingredient("thulecite", 2), Ingredient("silk", 10)}, RECIPETABS.WAR, TECH.MAGIC_THREE, nil, nil, nil, nil, "ishornet", "images/inventoryimages/hneedle2.xml", "hneedle2.tex")

STRINGS.RECIPE_DESC.HNEEDLE1 = "Bright and fancy."
STRINGS.RECIPE_DESC.HNEEDLE2 = "Bright and fancy."
STRINGS.RECIPE_DESC.HNEEDLE3 = "Bright and fancy."

AddRecipeToFilter("hneedle1", "WEAPONS")
AddRecipeToFilter("hneedle2", "WEAPONS")
AddRecipeToFilter("hneedle3", "WEAPONS")

AddRecipeToFilter("hneedle1", "CHARACTER")
AddRecipeToFilter("hneedle2", "CHARACTER")
AddRecipeToFilter("hneedle3", "CHARACTER")

AddRecipeToFilter("hneedle1", "MODS")
AddRecipeToFilter("hneedle2", "MODS")
AddRecipeToFilter("hneedle3", "MODS")

TUNING.HORNET_HEALTH = GetModConfigData("HORNET_HEALTH")
TUNING.HORNET_SANITY = GetModConfigData("HORNET_SANITY")
TUNING.HORNET_HUNGER = GetModConfigData("HORNET_HUNGER")
TUNING.HORNET_MOVESPEED = GetModConfigData("HORNET_MOVESPEED")
TUNING.HORNET_DAMAGEMULT = GetModConfigData("HORNET_DAMAGEMULT")
TUNING.HORNET_SILK = GetModConfigData("HORNET_SILK")
--TUNING.HORNET_FONT = GetModConfigData("HORNET_FONT")
