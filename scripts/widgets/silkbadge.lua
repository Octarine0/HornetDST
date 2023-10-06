local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Widget = require "widgets/widget"

--Constants
local TINT = { 245/255, 245/255, 245/255, 1 }
local assets= -- maybe?
{
    Asset("ANIM", "anim/status_silk.zip"),
}


local silkbadge = Class(Badge, function(self, owner)
    Badge._ctor(self, nil, owner, TINT, nil, nil, nil, true)

    self.num = self:AddChild(Text(BODYTEXTFONT, 33))
    self.num:SetHAlign(ANCHOR_MIDDLE)
    self.num:SetPosition(-80, -40, 0)
	self.num:SetClickable(false)
    self.num:Hide()

    self.sanityarrow = self.underNumber:AddChild(UIAnim())
    self.sanityarrow:GetAnimState():SetBank("sanity_arrow")
    self.sanityarrow:GetAnimState():SetBuild("sanity_arrow")
    self.sanityarrow:GetAnimState():AnimateWhilePaused(false)
    self.sanityarrow:SetClickable(false)

    self.val = 100
    self.arrowdir = nil
    --self:UpdateArrow()
    owner:ListenForEvent("silk_meter_update", function(owner,data)
        self.num.current = inst.name:value()
        self.percent = inst.name:value()  / self.num.max
    end)  
end)

function silkbadge:OnUpdate(dt) -- every time it updates i guess
    self.num:SetString(tostring(math.floor(self.num.current)))
    self.anim:GetAnimState():SetPercent("anim", 1 - self.percent) 
end

function silkbadge:UpdateArrow()
    local anim = self.isfullmoon and self.val > 0 and "arrow_loop_decrease_most" or "neutral"
    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.sanityarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

function silkbadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
    self.val = val
    self:UpdateArrow()
end

return silkbadge