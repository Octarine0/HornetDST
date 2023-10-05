PrefabFiles = {
	"hornet_none"
}

Assets = {
	Asset( "IMAGE", "bigportraits/hornet.tex" ),
    Asset( "ATLAS", "bigportraits/hornet.xml" ),

    Asset( "IMAGE", "bigportraits/hornet_none_oval.tex" ),
    Asset( "ATLAS", "bigportraits/hornet_none.xml" ),

    Asset( "IMAGE", "images/saveslot_portraits/hornet.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/hornet.xml" ),

    Asset( "IMAGE", "images/names_gold_hornet.tex" ),
    Asset( "ATLAS", "images/names_gold_hornet.xml" ),

    Asset("IMAGE", "images/inventoryimages/hneedle1.tex" ),
    Asset("ATLAS", "images/inventoryimages/hneedle1.xml"), 
}

local STRINGS = GLOBAL.STRINGS

STRINGS.NAMES.HORNET = "hornet"
STRINGS.SKIN_NAMES.hornet_none = "hornet"
STRINGS.SKIN_DESCRIPTIONS.wadix_none = "The look of a hunter."

STRINGS.CHARACTER_TITLES.hornet = "The Sentinel"
STRINGS.CHARACTER_NAMES.hornet = "Hornet"
STRINGS.CHARACTER_DESCRIPTIONS.hornet = "*Possesses a weaponised Needle\n*Moves Fast\n*Is suprisingly sane"
STRINGS.CHARACTER_QUOTES.hornet = "\"No shadow will haunt me...\""
STRINGS.CHARACTER_SURVIVABILITY.hornet = "Slim"
STRINGS.CHARACTER_ABOUTME.hornet = "Sample text."
STRINGS.CHARACTER_BIOS.hornet = {
 { title = "Birthday", desc = "October 10" },
 { title = "Favorite Food", desc = "Pumpkin Cookies" },
 { title = "Species", desc = "Spider?"},
}

TUNING.HORNET_HEALTH = 100
TUNING.HORNET_HUNGER = 150
TUNING.HORNET_SANITY = 150

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.HORNET = { "hneedle1"}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["hneedle1"] = {
    atlas = "images/inventoryimages/hneedle1.xml",
    image = "hneedle1.tex",
}

AddModCharacter("hornet", "FEMALE")