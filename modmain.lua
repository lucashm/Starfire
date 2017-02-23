PrefabFiles = {
	"starfire",
	"starfire_none",
	"energyball",
	"energyballfire",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/starfire.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/starfire.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/starfire.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/starfire.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/starfire_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/starfire_silho.xml" ),

    Asset( "IMAGE", "bigportraits/starfire.tex" ),
    Asset( "ATLAS", "bigportraits/starfire.xml" ),
	
	Asset( "IMAGE", "images/map_icons/starfire.tex" ),
	Asset( "ATLAS", "images/map_icons/starfire.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_starfire.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_starfire.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_starfire.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_starfire.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_starfire.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_starfire.xml" ),
	
	Asset( "IMAGE", "images/names_starfire.tex" ),
    Asset( "ATLAS", "images/names_starfire.xml" ),
	
    Asset( "IMAGE", "bigportraits/starfire_none.tex" ),
    Asset( "ATLAS", "bigportraits/starfire_none.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS


-- The energyball prefab item
STRINGS.NAMES.ENERGYBALL = "Starfire's energy"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ENERGYBALL = "It's Starfire's glowing thing!"

-- The character select screen lines
STRINGS.CHARACTER_TITLES.starfire = "Tamaran's Princess"
STRINGS.CHARACTER_NAMES.starfire = "Starfire"
STRINGS.CHARACTER_DESCRIPTIONS.starfire = "*Shoots energy balls\n*Gets stronger when low on sanity"
STRINGS.CHARACTER_QUOTES.starfire = "\"Do you wish to be my friend?\""

-- Custom speech strings
STRINGS.CHARACTERS.STARFIRE = require "speech_starfire"

-- The character's name as appears in-game 
STRINGS.NAMES.STARFIRE = "Starfire"

AddMinimapAtlas("images/map_icons/starfire.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("starfire", "FEMALE")

