AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString("LMMNPCROpenConfigMoney")
util.AddNetworkString("LMMNPCRCreateNPCMoney")

function ENT:Initialize()
	self:SetModel( "models/props/cs_assault/money.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self.health = 100
end

net.Receive("LMMNPCRCreateNPCMoney", function(len, ply)
	if table.HasValue(LMMNPCRConfig.AdminGroups, ply:GetUserGroup()) then
		local npc = net.ReadEntity()
		local id = net.ReadString()
		local max = net.ReadString()
		local min = net.ReadString()
		local pos = npc:GetPos()
		local ang = npc:GetAngles()
		local nick = string.gsub( ply:Nick(), "|", "Unknown admin(used bad name)" )
		
		file.Write("lmmnpcr_data/"..id.."_money.txt", id.."|"..pos.x.."|"..pos.y.."|"..pos.z.."|"..ang.x.."|"..ang.y.."|"..ang.z.."|"..min.."|"..max.."|"..nick.."("..ply:SteamID()..")")
		npc:Remove()
		timer.Simple(1, function()
			if file.Exists("lmmnpcr_data/"..id..".txt", "DATA") then
				ply:ChatPrint("The money spawn has been set!")
			else
				ply:ChatPrint("Something went wrong!")		
			end
		end)
	end
end)

function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		net.Start("LMMNPCROpenConfigMoney")
			net.WriteEntity(self)
		net.Send(Caller)
	end
end