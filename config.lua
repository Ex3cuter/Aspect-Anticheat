Aspect = {}

-- [Do not edit Developer Use only!]
Aspect.debug = false
Aspect.Versioncheck = "1.5.0"

-------------------------------------------------------

Aspect.ServerName = "Server Name" -- [YOUR SERVER NAME]
Aspect.BypassAce = "Aspect.Bypass" -- DONT TOUCH
Aspect.Discord = "discord.gg/CfEdp6sKfR" -- YOUR SERVERS DISCORD

-------------------------------------------------------

Aspect.AntiVPNDiscordLogs = true   -- ENABLE / DISABLE DISCORD LOGS
Aspect.AntiBlips = true  -- ANTI BLIPS ( DETECT PLAYER WHO ACTIVATE PLAYERS BLIPS )

-------------------------------------------------------
Aspect.WeaponProtection = true -- PROTECT PLAYERS FROM GETTING THERE WEAPONS REMOVED BY MODDERS
Aspect.TriggersProtection = true -- PROTECT AC TRIGGERS EXPLOITED BY MODDERS
Aspect.WordsProtection = true -- TURN ON TO ENABLE BLACKLISTED WORDS TO PREVENT SPAMMERS AND RACIST KIDS
Aspect.GiveWeaponsProtection = true -- ENABLE IF YOU USE ESX AND YOU WANT ANTI GIVE WEAPONS
Aspect.PlayerProtection = true -- PROTECT PLAYERS FROM BLACKLISTED EXPLOSIONS
Aspect.AntiClearPedTask = true -- ENABLE / DISABLE BLACKLISTED PEDS DETECTIONS
Aspect.AntiWeapons = true -- BANS PLAYERS WITH BLACKLISTED WEAPONS
Aspect.BlacklistedExplosions = true
Aspect.AntiSuperJump = true
Aspect.AntiGodmode = true
Aspect.AntiThermalVision = true
Aspect.AntiInvisble = true
Aspect.AntiNightVision = true
Aspect.AntiGiveArmour = true
Aspect.AntiPedChange = true
Aspect.AntiResourceStartandStop = false

-------------------------------------------------------

Aspect.AntiSpeedHack = true
Aspect.MaxSpeed = 10
------------------------------------------------------
Aspect.AntiKey = false
Aspect.BlacklistKeys = {
	{{121}, "Insert Key"},
	{{37, 44}, "Tab + Q Keys"},
	{{117}, "Numpad 7 Key"},
	{{214}, "Delete Key"},
    {{344}, "F11"},
}

Aspect.banmessages = {
	noclip = "Player Attempted To No-Clip",
	godmode = "Player Attempted To Enable Godmode",
	AntiClearPedTasks = "Player Tried To Clear Ped Task's",
	spectate = "Player Attempted To Specate Another Player",
	pedspeed = "Player Enabled Ped Speed Modifier",
	AntiTeleport = "Player Attempted To Teleport",
	PlayerBlips = "Player Attempted To Enable Player Blips",
	BlacklistedKeys = "Player Pressed A Blacklisted Key",
	VehicleModifier = "Player Enabled Vehicle Power Modifier",
	resourcestop = "Player Stopped/Started A Resource",
	invisible = "Player Enabled Invisibility",
	AntiNightVision = "Player Enabled Night Vision",
	ThermalVision = "Player Enabled Night Vision",
	Superjump = "Player Enabled Super Jump",
	BlacklistedWeapon = "Player Had a Blacklisted Weapon",
	CommandInjection = "Player Was Detected Using Command Injection",
	BlacklistedWords = "Player Said A Blacklisted Word In Chat",
}

-------------------------------------------------------

Aspect.Noclip = { --[Refer to documentation in discord for full info & details about this feature.]
	Enabled = true, --[true or false]
	TriggerCount = 1 --[Leave as is. Refer to documentation in discord for full info & details about this feature.]
} 

-------------------------------------------------------

Aspect.Framework = "ESX" -- SET YOUR FRAME WORK DONT TOUCH UNLESS YOU KNOW WHAT YOUR DOING
Aspect.SharedObject = "esx:getSharedObject" -- DO NOT TOUCH UNLESS YOU KNOW WHAT YOUR DOING

-------------------------------------------------------

Aspect.Logs = { --[ Refer to documentation in discord for full info & details about each feature below.]
	Kicks = {
		Enabled = true, --[true or false]
		Webhook = ''
	},
	Bans = {
		Enabled = true, --[true or false]
		Webhook = '' 
	},
	Unbans = {
		Enabled = true, --[true or false]
		Webhook = ''
	},

}

-------------------------------------------------------

Aspect.Spectate = { --[refer to documentation in discord for full info & details about this feature.]
	Enabled = true --[true or false]
}

-------------------------------------------------------

Aspect.VPNBlocker = { --[refer to documentation in discord for full info & details about this feature.]
	Enabled = true, --[true or false]
	Logs = {
		Enabled = true,
		Webhook = ''
	}
} 

------------------------------------------------------

Aspect.Tazers = { --[refer to documentation in discord for full info & details about this feature.]
	Enabled = true, --[true or false]
	ESX = {
		WhitelistedJobs = { 
			'police',
			'offpolice'
		}
	}
}
-------------------------------------------------------

Aspect.BlockedExplosions = { -- [Do not edit this array, If you do not know what your doing...]
	0,
--	1,  ### [Uncomment if you want users to be banned by hitting the gas pump Etcccc.]
	2,
	3,
	4,
	5,
	25,
	32,
	33,
	35,
	36,
	37,
	38,
}

-------------------------------------------------------
Aspect.WordsProtection = true
Aspect.AntiFakeChatMessages = true
Aspect.BlacklistedWords = { -- [Refer to documentation in discord for full info & details about each feature below.]
	"nigger",
    "faggot",
	"Desudo",
	"Brutan", 
	"EulenCheats", 
	"discord.gg/", 
	"lynxmenu", 
	"HamHaxia", 
	"Ham Mafia", 
	"www.renalua.com", 
	"Fallen#0811", 
	"Rena 8", 
	"HamHaxia",
	"Ham Mafia", 
	"Xanax#0134", 
	">:D Player Crash", 
	"discord.gg", 
	"34ByTe Community", 
	"lynxmenu.com", 
	"Anti-LRAC", 
	"Baran#8992", 
	"iLostName#7138", 
	"85.190.90.118", 
	"Melon#1379",
	"hammafia.com",
	"AlphaV ~ 5391", 	
	"vjuton.pl", 
	"Soviet Bear", 
	"XARIES", 
	"xaries", 
	"dc.xaries.pl", 
	"aries", 
	"aries.pl", 
	"youtube.com/c/Aries98/", 
	"Aries98", 
	"yo many", 
	"dezet",
	"333",
	"333GANG"
}

-------------------------------------------------------

Aspect.BlacklistedWeapons = { -- [Refer to documentation in discord for full info & details about each feature below.]
"WEAPON_KNUCKLE",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE", 
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_SWITCHBLADE",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_HAZARDCAN",
	"WEAPON_SNOWBALL",
	"WEAPON_FLARE",
	"WEAPON_REVOLVER",
	"WEAPON_POOLCUE",
	"WEAPON_PIPEWRENCH",
	"WEAPON_PISTOL_MK2",
	"WEAPON_FLAREGUN",
	"WEAPON_SMG_MK2",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN", 
	"WEAPON_DIGISCANNER",
	"WEAPON_NAVYREVOLVER",
	"WEAPON_CERAMICPISTOL",
	"WEAPON_STONE_HATCHET",
	"WEAPON_PIPEBOMB"
}

-------------------------------------------------------

Aspect.BlacklistedModels = { -- [Refer to documentation in discord for full info & details about each feature below.]
	"skylift",
	"valkyrie2",
	"airbus",
	"hunter",
	"bus",
	"armytanker",
	"armytrailer",
	"armytrailer2",
	"baletrailer",
	"boattrailer",
	"cablecar",
	"docktrailer",
	"freighttrailer",
	"graintrailer",
	"proptrailer",
	"raketrailer",
	"tr2",
	"tug",
	"tr3",
	"tr4",
	"trflat",
	"tvtrailer",
	"tanker",
	"tanker2",
	"trailerlarge",
	"trailerlogs",
	"trailersmall",
	"trailers",
	"trailers2",
	"trailers3",
	"trailers4",
	"RHINO",
	"AKULA",
	"SAVAGE",
	"HUNTER",
	"BUZZARD",
	"BUZZARD2",
	"ANNIHILATOR",
	"VALKYRIE",
	"HYDRA",
	"APC",
	"Trailersmall2",
	"Lazer",
	"oppressor",
	"mogul",
	"barrage",
	"Khanjali",
	"volatol",
	"chernobog",
	"avenger",
	"stromberg",
	"nightshark",
	"besra",
	"babushka ",
	"starling",
	"cargobob",
	"cargobob2",
	"cargobob3",
	"cargobob4",
	"caracara",
	"deluxo",
	"menacer",
    "scramjet",
    "oppressor2",
    "revolter",
    "viseris",
    "savestra",
    "thruster",
    "ardent",
    "dune3",
    "tampa3",
    "halftrack",
    "nokota",
    "strikeforce",
    "bombushka",
    "molotok",
    "pyro",
    "ruiner2",
    "limo2",
    "technical",
    "technical2",
    "technical3",
    "jb700w",
    "blazer5",
    "insurgent3",
	"boxville5",
	"bruiser",
    "bruiser2",
    "bruiser3",
    "brutus",
    "brutus2",
    "brutus3",
    "cerberus",
    "cerberus2",
    "cerberus3",
    "dominator4",
    "dominator5",
    "dominator6",
    "impaler2",
    "impaler3",
    "impaler4",
    "imperator",
    "imperator2",
    "imperator3",
    "issi4",
    "issi5",
    "issi6",
    "monster3",
    "monster4",
    "monster5",
    "scarab",
    "scarab2",
    "scarab3",
    "slamvan4",
    "slamvan5",
    "slamvan6",
    "zr380",
    "zr3802",
    "zr3803",
	"alphaz1",
	"avenger2",
	"blimp",
	"blimp2",
	"blimp3",
	"cargoplane",
	"cuban800",
	"dodo",
	"duster",
	"howard",
	"jet",
	"luxor",
	"luxor2",
	"mammatus",
	"microlight",
	"miljet",
	"nimbus",
	"rogue",
	"seabreeze",
	"shamal",
	"stunt",
	"titan",
	"tula",
	"velum",
	"velum2",
	"vestra",
	"s_m_y_swat_01",
	"a_m_o_acult_01",
	"ig_wade",
	"s_m_y_hwaycop_01",
	"A_M_Y_ACult_01",
	"s_m_m_movalien_01",
	"s_m_m_movallien_01",
	"u_m_y_babyd",
	"CS_Orleans",
	"A_M_Y_ACult_01",
	"S_M_M_MovSpace_01",
	"U_M_Y_Zombie_01",
	"s_m_y_blackops_01",
	"a_f_y_topless_01",
	"a_c_boar",
	"a_c_cat_01",
	"a_c_chickenhawk",
	"a_c_chimp",
	"s_f_y_hooker_03",
	"a_c_chop",
	"a_c_cormorant",
	"a_c_cow",
	"a_c_coyote",
	"a_c_crow",
	"a_c_dolphin",
	"a_c_fish",
	"s_f_y_hooker_01",
	"a_c_hen",
	"a_c_humpback",
	"a_c_husky",
	"a_c_killerwhale",
	"a_c_mtlion",
	"a_c_pigeon",
	"a_c_poodle",
	"a_c_pug",
	"a_c_rabbit_01",
	"a_c_rat",
	"a_c_retriever",
	"a_c_rhesus",
	"a_c_rottweiler",
	"a_c_sharkhammer",
	"a_c_sharktiger",
	"a_c_shepherd",
	"a_c_stingray",
	"a_c_westy",
	"CS_Orleans",
}

-------------------------------------------------------

Aspect.WhitelistedProps = { -- [Refer to documentation in discord for full info & details about each feature below.]
    "prop_ballistic_shield",
    "prop_fishing_rod_01",
    "prop_ld_shovel",
    "prop_tool_broom",
    "prop_phone_ing",
    "prop_npc_phone",
    "prop_cs_hand_radio",
    "ba_prop_battle_glowstick_01",
    "ba_prop_battle_hobby_horse",
    "p_amb_brolly_01",
    "prop_notepad_01",
    "prop_pencil_01",
    "hei_prop_heist_box",
    "prop_single_rose",
    "prop_cs_ciggy_01",
    "hei_heist_sh_bong_01",
    "prop_ld_suitcase_01",
    "prop_security_case_01",
    "prop_police_id_board",
    "p_amb_coffeecup_01",
    "prop_drink_whisky",
    "prop_amb_beer_bottle",
    "prop_plastic_cup_02",
    "prop_amb_donut",
    "prop_cs_burger_01",
    "prop_sandwich_01",
    "prop_ecola_can",
    "prop_choc_ego",
    "prop_drink_redwine",
    "prop_drink_champ",
    "prop_acc_guitar_01",
    "prop_el_guitar_01",
    "prop_el_guitar_03",
    "prop_novel_01",
    "prop_snow_flower_02",
    "v_ilev_mr_rasberryclean",
    "p_michael_backpack_s",
    "prop_tourist_map_01",
    "prop_beggers_sign_03",
    "prop_anim_cash_pile_01",
    "prop_pap_camera_01",
    "p_cs_joint_02",
    "prop_amb_ciggy_01",
    "prop_ld_case_01",
    "prop_cs_tablet",
    "prop_npc_phone_02",
    "prop_sponge_01",
}

-------------------------------------------------------

Aspect.ProtectedTriggers = { -- [Refer to documentation in discord for full info & details about each feature below.]
	"vrp_slotmachine:server:2",
	"Banca:deposit",
	"esx_jobs:caution",
	"esx_fueldelivery:pay",
	"esx_carthief:pay",
	"esx_godirtyjob:pay",
	"esx_pizza:pay",
	"esx_ranger:pay",
	"esx_garbagejob:pay",
	"esx_truckerjob:pay",
	"redst0nia:checking",
	"esx_gopostaljob:pay",
	"esx_banksecurity:pay",
	"esx_slotmachine:sv:2",
	"NB:recruterplayer",
	"esx_jailer:sendToJail",
	"js:jailuser",
	"esx_dmvschool:pay", 
	"LegacyFuel:PayFuel",
	"OG_cuffs:cuffCheckNearest",
	"CheckHandcuff",
	"dmv:success",
	"esx_dmvschool:addLicense",
	"esx_mechanicjob:startCraft",
	"esx_society:openBossMenu",
	"esx_jobs:caution",
	"esx_tankerjob:pay",
	"mission:completed",
	"truckerJob:success",
	"99kr-burglary:addMoney",
	"esx_jailer:unjailTime",
	"hentailover:xdlol",
	"antilynx8:anticheat",
	"antilynxr6:detection",
	"esx_society:getOnlinePlayers",
	"antilynx8r4a:anticheat",
	"antilynxr4:detect",
	"js:jailuser", 
	"ynx8:anticheat",
	"lynx8:anticheat",
	"h:xd",
	"ljail:jailplayer",
	"adminmenu:setsalary",
	"adminmenu:cashoutall",
	"paycheck:bonus",
	"paycheck:salary",
	"HCheat:TempDisableDetection",
	"esx-qalle-hunting:reward",
	"esx-qalle-hunting:sell",
	"esx_mecanojob:onNPCJobCompleted",
	"BsCuff:Cuff696999",
	"veh_SR:CheckMoneyForVeh",
	"esx_carthief:alertcops",
	"mellotrainer:adminTempBan",
	"mellotrainer:adminKick",
	"esx_society:putVehicleInGarage",
}
