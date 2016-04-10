AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.AddNetworkString("LMMNPCROpenConfig")
util.AddNetworkString("LMMNPCRCreateNPC")
util.AddNetworkString("LMMNPCRRemoveNPCCMD")

function ENT:Initialize()
	self:SetModel( "models/humans/group02/male_01.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE, CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	self.damage = 100
	self:SetMaxYawSpeed( 90 )
end

function ENT:OnTakeDamage( dmg )

	if self:GetNWFloat("LMMNPCRRobbingInProgress") == 1 then
		self:TakePhysicsDamage(dmg)
		
		self.damage = (self.damage or 100) - dmg:GetDamage()
		if self.damage <= 0 then			
			dmg:GetInflictor():ChatPrint("You killed the NPC!")
			LMMNPCRStopRobbing(dmg:GetInflictor(), self)
		end	
	end
end

function LMMNPCRRespawnNPCR(theid)
	for k, v in pairs(file.Find("lmmnpcr_data/*.txt", "DATA")) do
		local npcrfile = file.Read("lmmnpcr_data/"..v)
		local tbl = string.Explode("|", npcrfile)
		
		local endswith = string.EndsWith( v, "_money.txt" )
		if !endswith then
			local name = tbl[1]
			local id = tbl[2]
			local model = tbl[4]
			local colorr = tbl[4]
			local colorg = tbl[5]
			local colorb = tbl[6]
			local colora = tbl[7]
			local pos = Vector(tonumber(tbl[8]), tonumber(tbl[9]), tonumber(tbl[10]))
			local ang = Angle(tonumber(tbl[11]), tonumber(tbl[12]), tonumber(tbl[13]))
			local creator = tbl[13]
			
			print("v: "..v)
			print("id npc: "..id)
			print("id: "..theid)
			
			if file.Exists("lmmnpcr_data/"..string.StripExtension(v).."_money.txt", "DATA") then
				local npcrfilemoney = file.Read("lmmnpcr_data/"..string.StripExtension(v).."_money.txt", "DATA")
				local tbl2 = string.Explode("|", npcrfilemoney)
				
				posx = tbl2[2]
				posy = tbl2[3] 
				posz = tbl2[4] 
				angx = tbl2[5] 
				angy = tbl2[6] 
				angz = tbl2[7]
				min = tbl2[8]
				max = tbl2[9]
			else
				posx = 0
				posy = 0
				posz = 0
				angx = 0
				angy = 0
				angz = 0
			end
			
			if id == theid then
				MsgC(Color(255,0,0), "LMMNPCR spawning npc id: "..id.."\n")
				
				
				local npc = ents.Create("lmm_npcr")
				npc:Spawn()
				npc:SetPos( pos )
				npc:SetAngles( ang )
				npc:SetModel( model )
				npc:SetNWString("LMMNPCRName", name)
				npc:SetNWString("LMMNPCRID", id)
				npc:SetNWString("LMMNPCRCreator", creator)
				npc:SetNWFloat("LMMNPCRColorR", colorr)
				npc:SetNWFloat("LMMNPCRColorG", colorg)
				npc:SetNWFloat("LMMNPCRColorB", colorb)
				npc:SetNWFloat("LMMNPCRColorA", colora)
				
				npc:SetNWFloat("LMMNPCRPosX", posx)
				npc:SetNWFloat("LMMNPCRPosY", posy)
				npc:SetNWFloat("LMMNPCRPosZ", posz)
				npc:SetNWFloat("LMMNPCRAngX", angx)
				npc:SetNWFloat("LMMNPCRAngY", angy)
				npc:SetNWFloat("LMMNPCRAngZ", angz)
				
				npc:SetNWFloat("LMMNPCRMax", max)
				npc:SetNWFloat("LMMNPCRMin", min)
				
				npc:SetNWFloat("LMMNPCRRobbingInProgress", 0)
				
				npc:DropToFloor()	
			end
		end								
	end		
end

function LMMNPCRSpawnNPCRAuto()
		for k, v in pairs(file.Find("lmmnpcr_data/*.txt", "DATA")) do
		local npcrfile = file.Read("lmmnpcr_data/"..v)
		local tbl = string.Explode("|", npcrfile)

		local endswith = string.EndsWith( v, "_money.txt" )
		if !endswith then
			local name = tbl[1]
			local id = tbl[2]
			local model = tbl[4]
			local colorr = tbl[4]
			local colorg = tbl[5]
			local colorb = tbl[6]
			local colora = tbl[7]
			local pos = Vector(tonumber(tbl[8]), tonumber(tbl[9]), tonumber(tbl[10]))
			local ang = Angle(tonumber(tbl[11]), tonumber(tbl[12]), tonumber(tbl[13]))
			local creator = tbl[13]
			
			if file.Exists("lmmnpcr_data/"..string.StripExtension(v).."_money.txt", "DATA") then
				local npcrfilemoney = file.Read("lmmnpcr_data/"..string.StripExtension(v).."_money.txt", "DATA")
				local tbl2 = string.Explode("|", npcrfilemoney)
				
				posx = tbl2[2]
				posy = tbl2[3] 
				posz = tbl2[4] 
				angx = tbl2[5] 
				angy = tbl2[6] 
				angz = tbl2[7]
				min = tbl2[8]
				max = tbl2[9]
			else
				posx = 0
				posy = 0
				posz = 0
				angx = 0
				angy = 0
				angz = 0
			end
			
			
			MsgC(Color(255,0,0), "LMMNPCR spawning npc id: "..id.."\n")
			
			local npc = ents.Create("lmm_npcr")
			npc:Spawn()
			npc:SetPos( pos )
			npc:SetAngles( ang )
			npc:SetModel( model )
			npc:SetNWString("LMMNPCRName", name)
			npc:SetNWString("LMMNPCRID", id)
			npc:SetNWString("LMMNPCRCreator", creator)
			npc:SetNWFloat("LMMNPCRColorR", colorr)
			npc:SetNWFloat("LMMNPCRColorG", colorg)
			npc:SetNWFloat("LMMNPCRColorB", colorb)
			npc:SetNWFloat("LMMNPCRColorA", colora)
			
			npc:SetNWFloat("LMMNPCRPosX", posx)
			npc:SetNWFloat("LMMNPCRPosY", posy)
			npc:SetNWFloat("LMMNPCRPosZ", posz)
			npc:SetNWFloat("LMMNPCRAngX", angx)
			npc:SetNWFloat("LMMNPCRAngY", angy)
			npc:SetNWFloat("LMMNPCRAngZ", angz)
			
			npc:SetNWFloat("LMMNPCRMax", max)
			npc:SetNWFloat("LMMNPCRMin", min)
			
			npc:SetNWFloat("LMMNPCRCooldown", 0)
			
			npc:SetNWFloat("LMMNPCRRobbingInProgress", 0)
			
			npc:DropToFloor()	
		end								
	end		
end
hook.Add( "InitPostEntity", "LMMNPCRSpawnNPCRAuto", LMMNPCRSpawnNPCRAuto)

net.Receive("LMMNPCRCreateNPC", function(len, ply)
	if table.HasValue(LMMNPCRConfig.AdminGroups, ply:GetUserGroup()) then
		local npc = net.ReadEntity()
		local name = net.ReadString()
		local id = net.ReadString()
		local model = net.ReadString()
		local color = net.ReadTable()
		local pos = npc:GetPos()
		local ang = npc:GetAngles()
		
		if model == "default" then
			model = "models/humans/group02/male_01.mdl"
		end
		
		file.Write("lmmnpcr_data/"..id..".txt", name.."|"..id.."|"..model.."|"..color.r.."|"..color.g.."|"..color.b.."|"..color.a.."|"..pos.x.."|"..pos.y.."|"..pos.z.."|"..ang.x.."|"..ang.y.."|"..ang.z.."|"..ply:Nick().."("..ply:SteamID()..")")
		npc:Remove()
		timer.Simple(1, function()
			if file.Exists("lmmnpcr_data/"..id..".txt", "DATA") then
				ply:ChatPrint("This NPC has been saved! Please restart your server to spawn the NPC with all its info!")
			else
				ply:ChatPrint("Something went wrong! Make sure your id is something with no spaces like 'store1'!")		
			end
		end)
	end
end)

net.Receive("LMMNPCRRemoveNPCCMD", function(len, ply)
	if table.HasValue(LMMNPCRConfig.AdminGroups, ply:GetUserGroup()) then
		local id = net.ReadString()
		for k, v in pairs(file.Find("lmmnpcr_data/*.txt", "DATA")) do
			if v == id..".txt" then
				ply:ChatPrint("NPC Removed!")
				file.Delete("lmmnpcr_data/"..id..".txt", "DATA")
				file.Delete("lmmnpcr_data/"..id.."_money.txt", "DATA")
				ply:ChatPrint("Please restart the server to get rid of all the remove npcs!")
				return
			else
			
			end		
		end
	end
	ply:ChatPrint("Invalid ID")
end)

local function LMMNPCROpenInGameConfig(self, ply)
	net.Start("LMMNPCROpenConfig")
		net.WriteEntity(self)
	net.Send(ply)
end

function LMMNPCRStopRobbing(ply, self)
	if self:GetNWFloat("LMMNPCRRobbingInProgress") ==1 then
		self:SetNWFloat("LMMNPCRRobbingInProgress", 0)
		timer.Destroy("LMMNPCRSoundTimer")
		timer.Destroy("LMMNPCRMoneySpawnTimer")
		timer.Destroy("LMMNPCRCheckForLocationTimer")
		ply:ChatPrint("The robbary is now over!")
		self:SetNWFloat("LMMNPCRCooldown", 1)
		self:SetNWFloat("LMMNPCRGetCooldownTime", CurTime())		
		timer.Simple(LMMNPCRConfig.CooldownTime * 60, function()
			self:SetNWFloat("LMMNPCRCooldown", 0)
		end)
	end
end


local function LMMNPCRChatCommand(ply, text)
	local text = string.lower(text)
	if(string.sub(text, 0, 10)== "!npcrsetup" or string.sub(text, 0, 10)== "/npcrsetup") then
		if table.HasValue(LMMNPCRConfig.AdminGroups, ply:GetUserGroup()) then
			if ply:GetEyeTrace().Entity:GetClass() == "lmm_npcr" then
				if ply:GetEyeTrace().Entity:GetNWString("LMMNPCRID") == "" then
					LMMNPCROpenInGameConfig(ply:GetEyeTrace().Entity, ply)
				else
					ply:ChatPrint("This NPC is already configured! Please type 'LMMNPCR_remove "..ply:GetEyeTrace().Entity:GetNWString("LMMNPCRID").."' in console to remove the NPC and its data!")
				end
			else
				ply:ChatPrint("You need to look at a robbable npc and enter the command again!")
			end
			return ''
		else
			ply:ChatPrint("You need to be admin to run this command!")
			return ''
		end
	end
end 
hook.Add("PlayerSay", "LMMNPCRChatCommand", LMMNPCRChatCommand)

function LMMNPCRPlayerDeath( victim, inflictor, attacker )
	for k, v in pairs(ents.FindByClass("lmm_npcr")) do
		if v:GetNWFloat("LMMNPCRRobbingInProgress") == 1 then
			if v:GetNWEntity("LMMNPCRPlayerRobbing") == victim then
				LMMNPCRStopRobbing(victim, v)
			end
		end	
	end
end
hook.Add("PlayerDeath", "LMMNPCRPlayerDeath", LMMNPCRPlayerDeath)

function LMMNPCRplayerArrested(criminal, time, actor)
	for k, v in pairs(ents.FindByClass("lmm_npcr")) do
		if v:GetNWFloat("LMMNPCRRobbingInProgress") == 1 then
			if v:GetNWEntity("LMMNPCRPlayerRobbing") == criminal then
				LMMNPCRStopRobbing(criminal, v)
			end
		end	
	end
end
hook.Add("playerArrested", "LMMNPCRplayerArrested", LMMNPCRplayerArrested)

function LMMNPCRStartRobbing( ply, self )
	
	if self:GetNWFloat("LMMNPCRCooldown") == 1 then 
		return
	end
	
	if self:GetNWFloat("LMMNPCRRobbingInProgress") == 1 then
		return
	end
	
	self.damage = 100
	
--	local randomsa = math.random(1,10)
	local randomsa = 1
	
	if randomsa == 1 then
		self:SetNWFloat("LMMNPCRRobbingInProgress", 1)
		self:SetNWEntity("LMMNPCRPlayerRobbing", ply)
		self:EmitSound(LMMNPCRConfig.SoundOfAlarm)
		timer.Create("LMMNPCRSoundTimer", 3, 0, function()
			self:EmitSound(LMMNPCRConfig.SoundOfAlarm)
		end)
		ply:ChatPrint("The police were notified about the robbary! You better hurry")
		for k, v in pairs(player.GetAll()) do
			if v:isCP() then
				v:ChatPrint("The alarm has gone off at a store! Go check to stop the robber!")
			end
		end
		timer.Create("LMMNPCRMoneySpawnTimer", LMMNPCRConfig.TimeToEmitCash, 0, function()
			pos = Vector(self:GetNWFloat("LMMNPCRPosX"), self:GetNWFloat("LMMNPCRPosY"), self:GetNWFloat("LMMNPCRPosZ"))		
			amount = math.random(self:GetNWFloat("LMMNPCRMax"), self:GetNWFloat("LMMNPCRMin"))
			DarkRP.createMoneyBag(pos, amount)
		end)
		timer.Simple(LMMNPCRConfig.RobbaryMaxTime * 60, function()
			LMMNPCRStopRobbing(ply, self)
		end)
	else
		self:SetNWFloat("LMMNPCRRobbingInProgress", 1)	
		self:SetNWEntity("LMMNPCRPlayerRobbing", ply)		
		ply:ChatPrint("Ok ok! Ill get the money hold on! Don't hurt me!")
		timer.Create("LMMNPCRMoneySpawnTimer", LMMNPCRConfig.TimeToEmitCash, 0, function()
			pos = Vector(self:GetNWFloat("LMMNPCRPosX"), self:GetNWFloat("LMMNPCRPosY"), self:GetNWFloat("LMMNPCRPosZ"))		
			amount = math.random(self:GetNWFloat("LMMNPCRMax"), self:GetNWFloat("LMMNPCRMin"))
			DarkRP.createMoneyBag(pos, amount)
		end)
		timer.Create("LMMNPCRCheckForLocationTimer", .1, 0, function()
			if ( self:GetPos():Distance(ply:GetPos()) > LMMNPCRConfig.MaxDistanceAwayFromNPC) then
				LMMNPCRStopRobbing(ply, self)
			end
		end)
		timer.Simple(LMMNPCRConfig.RobbaryMaxTime * 60, function()
			LMMNPCRStopRobbing(ply, self)
		end)		
	end
end

/*
for k, v in pairs(ents.FindByClass("lmm_npcr")) do
	LMMNPCRStopRobbing(nil, v)
	v:SetNWFloat("LMMNPCRCooldown", 0)
	v:SetNWFloat("LMMNPCRGetCooldownTime", nil)
end
*/

function ENT:AcceptInput( Name, Activator, Caller )		
	if Name == "Use" and Caller:IsPlayer() then
		if  Caller:GetEyeTrace().Entity == self and table.HasValue( LMMNPCRConfig.WeaponsThatCanRob, Caller:GetActiveWeapon():GetClass()) and table.HasValue(LMMNPCRConfig.JobsThatCanRob, team.GetName(Caller:Team()))then
			if self:GetNWFloat("LMMNPCRCooldown") == 1 then
				Caller:ChatPrint("Hey man i just got robbed please go away!")
			else
				if self:GetNWFloat("LMMNPCRRobbingInProgress") == 1 then
					Caller:ChatPrint("Im getting the money hold on!")
				else
					LMMNPCRStartRobbing(Caller, self)
				end
			end
		else
			Caller:ChatPrint("Tip: Become a criminal job and hold a weapon to rob the NPC!")
		end
	end
end