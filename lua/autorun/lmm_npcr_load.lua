if (SERVER) then
	AddCSLuaFile('lmm_npcr_config.lua')
	include('lmm_npcr_config.lua')
end

if (CLIENT) then
	include('lmm_npcr_config.lua')
end