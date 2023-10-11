local Silk = Class(function(self, inst)
    self.inst = inst
    self.currentSilk = 50
    self.maxSilk = 100

end, nil, {})

function Silk:Setup()
	self.maxSilk = 100
    self.currentSilk = 50
end

function Silk:OnSave()
    local data = {}
    data.currentSilk = self.currentSilk
    if(self.maxSilk ~= 100) then 
        data.maxSilk = self.maxSilk
    end
    return data or nil
end

function Silk:OnLoad(data)
    if(data.maxSilk ~= nil) then
        self.maxSilk = data.maxSilk
    end
    if(data.currentSilk ~= nil) then
        self.currentSilk = data.currentSilk
    end
end

return Silk