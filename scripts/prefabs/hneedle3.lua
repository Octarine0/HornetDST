local assets=
{
    Asset("ANIM", "anim/hneedle3.zip"),
    Asset("ANIM", "anim/swap_hneedle3.zip"),
    Asset("ATLAS", "images/inventoryimages/hneedle3.xml"),
    Asset("IMAGE", "images/inventoryimages/hneedle3.tex"),
}

prefabs = {}

local function fn()

	local function OnEquip(inst, owner)
		owner.AnimState:OverrideSymbol("swap_object", "swap_hneedle3", "swap_hneedle3")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	end    

	local function OnUnequip(inst, owner)        
		owner.AnimState:Hide("ARM_carry")        
		owner.AnimState:Show("ARM_normal")    
	end   
 
	local inst = CreateEntity()    
	local trans = inst.entity:AddTransform()    
	local anim = inst.entity:AddAnimState()    
	local sound = inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst) 
	
	anim:SetBank("hneedle3")    
	anim:SetBuild("hneedle3")    
	anim:PlayAnimation("idle")    

	if not TheWorld.ismastersim then
		return inst
	end
	inst.entity:SetPristine()

	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(60)

	inst:AddComponent("inspectable")        
	inst:AddComponent("inventoryitem")  
  
	inst.components.inventoryitem.imagename = "hneedle3"    
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hneedle3.xml" 

	local function OnEquip(inst, owner)
		if owner:HasTag("ishornet") then
			owner.AnimState:OverrideSymbol("swap_object", "swap_hneedle3", "swap_hneedle3")
			owner.AnimState:Show("ARM_carry")
			owner.AnimState:Hide("ARM_normal")
		else
            inst:DoTaskInTime(0, function()
                if owner and owner.components and owner.components.inventory then
                    owner.components.inventory:GiveItem(inst)
                    if owner.components.talker then
                        owner.components.talker:Say("This needle wasn't made for me, it's too difficult to use.")
                    end
                end
            end)
        end 
	end
   
	inst:AddComponent("equippable")    
	inst.components.equippable:SetOnEquip( OnEquip )    
	inst.components.equippable:SetOnUnequip( OnUnequip )    
	return inst
end

return Prefab("common/inventory/hneedle3", fn, assets, prefabs)