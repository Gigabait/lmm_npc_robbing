LMMNPCRConfig = {}
LMMNPCRConfig.DevMode = false -- Do not touch this.. its not a playable version.. (its for testing LEAVE TO FALSE)
/*
	Made By: XxLMM13xXgaming
*/
LMMNPCRConfig.JobsThatCanRob = { -- Jobs that can rob
	"Gangster"
}

LMMNPCRConfig.WeaponsThatCanRob = { -- Weapons that the robber needs to be holding
	"weapon_357",
	"weapon_ar2",
	"weapon_crossbow",
	"weapon_pistol",
	"weapon_rpg",
	"weapon_shotgun",
	"weapon_smg1"
}

LMMNPCRConfig.AdminGroups = {"superadmin", "admin", "owner"} -- Groups considered 'admin'

LMMNPCRConfig.PoliceTeams = { -- Jobs considered 'police'
	"Civil Protection",
	"Civil Protection Chief"
}

LMMNPCRConfig.SoundOfAlarm = "npc/attack_helicopter/aheli_damaged_alarm1.wav" -- The sound the alarm is

LMMNPCRConfig.TimeToEmitCash = 5 -- Every x sec the npc will drop a random amount of cash!

LMMNPCRConfig.RobbaryMaxTime = 2 -- Max time in min the robbary can last!

LMMNPCRConfig.MaxDistanceAwayFromNPC = 500 -- How far a player can go before the raid is over

LMMNPCRConfig.CooldownTime = .1 -- Time in min that the cooldown is