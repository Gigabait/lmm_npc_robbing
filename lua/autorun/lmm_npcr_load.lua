if (SERVER) then
	if not file.Exists("lmmnpcr_data", "DATA") then
		file.CreateDir("lmmnpcr_data")
	end
	AddCSLuaFile('lmm_npcr_config.lua')
	include('lmm_npcr_config.lua')
end

if (CLIENT) then
	include('lmm_npcr_config.lua')
end
