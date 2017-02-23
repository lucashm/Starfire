local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()

	inst:AddTag("FX")
    inst:AddTag("playerlight")

    inst.Light:SetIntensity(.75)
	inst.Light:SetColour(255/255, 255/255, 100/255)
    inst.Light:SetFalloff(1)
    inst.Light:SetRadius(1)
    inst.Light:Enable(true)

    inst.persists = false

    return inst
end

return Prefab("swiftspherefire", fn, nil)