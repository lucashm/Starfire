local assets=
{    
	Asset("ANIM", "anim/energyball.zip"),    
	Asset("ANIM", "anim/swap_energyball.zip"),    
	Asset("ATLAS", "images/inventoryimages/energyball.xml"),    
	Asset("IMAGE", "images/inventoryimages/energyball.tex"),
}

local prefabs = 
{
	"energyballfire",
}
--local function fn()    

local function OnEquip(inst, owner)        
	owner.AnimState:OverrideSymbol("swap_object", "swap_energyball", "swap_energyball")        
	owner.AnimState:Show("ARM_carry")        
	owner.AnimState:Hide("ARM_normal")  	
	
    --if inst.fire == nil then
		inst.fire = SpawnPrefab("energyballfire")
		local follower = inst.fire.entity:AddFollower()
		follower:FollowSymbol(owner.GUID, "swap_object", 0, -110, 1)    
    --end
		
end    

local function OnUnequip(inst, owner)     

    if inst.fire ~= nil then
        inst.fire:Remove()
        inst.fire = nil
    end
	
	owner.AnimState:Hide("ARM_carry")        
	owner.AnimState:Show("ARM_normal")   
	
end    

local function onattack_red(inst, attacker, target, skipsanity)

    --attacker.SoundEmitter:PlaySound("dontstarve/wilson/fireball_explo")
	target.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_impact_fire")
    if not target:IsValid() then
        --target killed or removed in combat damage phase
        return
    end

   -- if target.components.burnable ~= nil and not target.components.burnable:IsBurning() then
   --     if target.components.freezable ~= nil and target.components.freezable:IsFrozen() then
   --         target.components.freezable:Unfreeze()
   --     elseif target.components.fueled == nil then
   --         target.components.burnable:Ignite(true)
   --     elseif target.components.fueled.fueltype == FUELTYPE.BURNABLE
   --         or target.components.fueled.secondaryfueltype == FUELTYPE.BURNABLE then
   --         local fuel = SpawnPrefab("cutgrass")
   --         if fuel ~= nil then
   --             if fuel.components.fuel ~= nil and
   --               fuel.components.fuel.fueltype == FUELTYPE.BURNABLE then
   --                 target.components.fueled:TakeFuelItem(fuel)
   --             else
   --                 fuel:Remove()
   --             end
   --         end
   --     end
        --V2C: don't ignite if it doens't accespt burnable fuel!
    --end

    if target.components.freezable ~= nil then
        target.components.freezable:AddColdness(-1) --Does this break ice staff?
        if target.components.freezable:IsFrozen() then
            target.components.freezable:Unfreeze()
        end
    end

    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

    target:PushEvent("attacked", { attacker = attacker, damage = 0 })
end

local function fn()	
	local inst = CreateEntity()    
	local trans = inst.entity:AddTransform()    
	local anim = inst.entity:AddAnimState()    
	local sound = inst.entity:AddSoundEmitter()  
	inst.entity:AddLight() --light is not a component
	inst.entity:AddNetwork()

	
	if not TheWorld.ismastersim then
		return inst
	end 
		
	MakeInventoryPhysics(inst)        
	anim:SetBank("energyball")    
	anim:SetBuild("energyball")    
	anim:PlayAnimation("idle")    
	inst:AddComponent("inspectable")        
	inst:AddComponent("inventoryitem")    
	inst.components.inventoryitem.imagename = "energyball"    
	inst.components.inventoryitem.atlasname = "images/inventoryimages/energyball.xml"        
	inst:AddComponent("equippable")    
	inst.components.equippable:SetOnEquip( OnEquip )    
	inst.components.equippable:SetOnUnequip( OnUnequip )   
	
	
	inst.components.inventoryitem.onputininventoryfn = function(inst, player)		
		if player.prefab ~= "starfire" then			
			inst:DoTaskInTime(0.1, function()				
			player.components.inventory:DropItem(inst)
			player.components.talker:Say("This is too powerfull for me!")			
			end)		
		end	
	end
	
		inst.Light:SetIntensity(.8)
		inst.Light:SetRadius(4)
		inst.Light:SetFalloff(.6)
		inst.Light:SetColour(32/255, 255/255, 32/255)
		inst.Light:Enable(true)
		inst.Light:EnableClientModulation(true)
		
	inst:AddComponent("weapon")
		inst.components.weapon:SetDamage(20)
		inst.components.weapon:SetRange(8, 10)
		inst.components.weapon:SetOnAttack(onattack_red)
		inst.components.weapon:SetProjectile("fire_projectile")
		
		MakeHauntableLaunch(inst)	


		return inst
	end 
	
	return  Prefab("energyball", fn, assets, prefabs)	