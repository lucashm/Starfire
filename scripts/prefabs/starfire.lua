
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
	"energyball",
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when reviving from ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "starfire_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "starfire_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local function becomestarfire(inst)
		inst.transform = false
        inst.AnimState:SetBuild("starfire")
		inst.components.combat.damagemultiplier = 1
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1)			
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1)
end

local function transform(inst)
		inst.transform = true
        inst.AnimState:SetBuild("starfire_transform")
 		inst.components.combat.damagemultiplier = 2
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.25)			
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.25)
     
end

local becomeformtreshold =  50
local unbecomeformtreshold =  51

local function sanity_event_listener(inst, data)
	
	if inst.components.sanity.current <= becomeformtreshold and not inst.transform then        
		transform(inst)
	elseif inst.components.sanity.current >= unbecomeformtreshold and inst.transform then
		becomestarfire(inst)				
	end	

end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "starfire.tex" )
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(150)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1.3 * TUNING.WILSON_HUNGER_RATE
	inst.components.sanity.night_drain_mult = 1.1
	inst.components.sanity.neg_aura_mult = 1.1
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	inst:ListenForEvent("sanitydelta", sanity_event_listener) 
end



return MakePlayerCharacter("starfire", prefabs, assets, common_postinit, master_postinit, start_inv)
