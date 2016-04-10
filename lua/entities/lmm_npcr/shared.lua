ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Robbable NPC"
ENT.Category = "Robbable NPC"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true  
 
function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end