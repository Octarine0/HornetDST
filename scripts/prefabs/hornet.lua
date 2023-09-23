local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

--Hornet's stats. Static method incase I break something in the config
--TUNING.HORNET_HEALTH = 100
--TUNING.HORNET_HUNGER = 150
--TUNING.HORNET_SANITY = 150
--TUNING.HORNET_MOVESPEED = 1.25
--TUNING.HORNET_DAMAGEMULT = 1
--TUNING.HORNET_HUNGER_RATE = 1

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.HORNET = {
	"flint",
	"flint",
	"twigs",
	"twigs",
	"hneedle1",
}

local start_inv = {
	"hneedle1",
}

for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.HORNET
end

local prefabs = FlattenTree(start_inv, true)

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "hornet_speed_mod", TUNING.HORNET_MOVESPEED)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "hornet_speed_mod")
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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Battle sanity mechanics. All WIP
local function onEndHornetComfort(receiver, comforterGUID, comfortAuraUID) -- Mostly done I think... Who knows.
	-- In here I put the cancelling code
	print("onEndHornetComfort has been activated... Debug info") -- Debugging stuff
	if not receiver or not receiver:IsValid() then
		print("We didn't end it this time...")
		return
	end
	
	if receiver[comfortAuraUID] then
		receiver[comfortAuraUID]:Cancel()
		receiver[comfortAuraUID] = nil
	end
end

local function onApplyHornetComfort(receiver, comforter) -- This function seems done... Currently doesn't end. (Warning, function almost certainly not done or functional)
	print("onApplyHornetComfort has been activated... Debug info") -- Debugging stuff
	
	if not receiver or not receiver:IsValid() then
		return
	end -- This... This is self explanatory. Crash prevention
	
	local comforterGUID = comforter.GUID -- Just to make things pretty really
	local comfortAuraUID = "hornetComfortAura"..comforterGUID -- Unique ID's baby
	
	if not receiver[comfortAuraUID] then
		receiver[comfortAuraUID] = receiver:DoPeriodicTask(1.0, function(receiver) -- Number is the interval for aura effect application
			if receiver.components.sanity then -- To ensure sanity exists on the character. Crash prevention...
				receiver.components.sanity:DoDelta(0.75) -- Number is the sanity gain per interval. The true prevents the pulsing that food and one-off stuff does receiver.components.sanity:DoDelta(3.0, true)
			end
		end)
	end
	
	local endComfortAuraUID = "hornetEntireAura"..comforterGUID
	
	-- Just a refresher for the timer. May want to do it differently, undecided. Either way, resets the timer before we set it.
	if receiver[endComfortAuraUID] then
		receiver[endComfortAuraUID]:Cancel()
		receiver[endComfortAuraUID] = nil
	end
	
	-- Ends the aura in 10 seconds, time will need adjusted
	receiver[endComfortAuraUID] = receiver:DoTaskInTime(3.0, onEndHornetComfort, comforterGUID, comfortAuraUID)
	--receiver[endComfortAuraUID] = receiver:DoTaskInTime(10.0, onEndHornetComfort, receiver, comforterGUID, comfortAuraUID)
end 

local function applyHornetComfortRange(inst) -- I think this is done
	-- In here I have to figure out how big the range of the aura should be and apply it like that.
	local x, y, z = inst.Transform:GetWorldPosition()
	--The 20 is the closeness in units. Not sure what units...
	local closePlayers = TheSim:FindEntities(x, y, z, 20, {"player"}, {"playerghost", "INLIMBO"}, nil) --currently affects self as well. Could disable for all hornets...
	-- Check wigfrid for a better implimentation method
	
	for i, v in ipairs(closePlayers) do
		print(tostring(inst), " gave Comforting Aura to ", tostring(v))
		onApplyHornetComfort(v, inst)
	end
end

local function onAttackOther(inst, data) -- Appears to work and trigger fine.
	-- One of the two triggering conditions
	print("onAttackOther has been activated... Debug info") -- Debugging stuff
	if not data.target or not data.target:IsValid() or (data.target:HasTag("prey") and not data.target:HasTag("frog")) or data.target:HasTag("butterfly") or not data.target.components.combat then
		return
	end -- Various abuse prevention methods
	print("Checking Range")
	applyHornetComfortRange(inst) --Calls the range check function, which will in turn call the applier
end

local function onEnemyAttackHornet() -- Definitely not done
	-- Make sure to do a check that it's an enemy, not just any source of damage like the thorns charm in the Hollow Knight mod probably does... (Pretty sure that's the issue)
	-- The other of the two triggering conditions... I wonder if I could make these a single function. Maybe "onHornetComfortTrigger"?
end

--The End of WIP
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "hornet.tex" )
	
	--Tags the character as hornet
	inst:AddTag("ishornet")
	
	--Custom speech font
	inst.components.talker.font = TALKINGFONT_HORNET
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.HORNET_HEALTH)
	inst.components.hunger:SetMax(TUNING.HORNET_HUNGER)
	inst.components.sanity:SetMax(TUNING.HORNET_SANITY)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = TUNING.HORNET_DAMAGEMULT
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	inst:ListenForEvent("onattackother", onAttackOther)
	--inst:ListenForEvent("attacked", OnAttacked)
end

return MakePlayerCharacter("hornet", prefabs, assets, common_postinit, master_postinit, start_inv)
