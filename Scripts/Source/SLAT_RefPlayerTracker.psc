Scriptname SLAT_RefPlayerTracker extends ReferenceAlias  

SLAT_QuestCommonProperties Property CommonProperties Auto
SLAT_QuestIntegrations Property Integrations Auto
Faction Property slaNakedFaction Auto

SexLabFramework SexLab
Actor player

event OnInit()
	SexLab = SexLabUtil.GetAPI()
	player = Game.GetPlayer()
	Spell MasturbatePower = CommonProperties.MasturbatePower
	Spell TeasePower = CommonProperties.TeasePower
	player.AddSpell(MasturbatePower, false)
	player.AddSpell(TeasePower, false)
endEvent

event OnReset()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) >= 0
	UnregisterForAllModEvents()
		
	RegisterForModEvent("HookAnimationStart", "OnSexLabAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnSexLabAnimationEnd")
	
	UnregisterForUpdate()
	RegisterForUpdate(CommonProperties.PlayerRuntimeVariablesUpdateInterval)
endEvent

Event OnSexlabAnimationStart(int tid, bool hasPlayer)
	Debug.Trace("[MoaH] SexLabAnimationStart")
	sslThreadController thread = SexLab.GetController(tid)
	if(thread.hasPlayer)
		Debug.Trace("[SLAT] Player is having sex.")
		Debug.Notification("[SLAT] Player is having sex.")
		CommonProperties.PlayerIsHavingSex = true
	endIf
endEvent

Event OnSexlabAnimationEnd(int tid, bool hasPlayer)
	Debug.Trace("[MoaH] SexLabAnimationEnd")
			
	sslThreadController thread = SexLab.GetController(tid)
	if(hasPlayer)
		Debug.Trace("[SLAT] Player is having sex. (ending)")
		Debug.Notification("[SLAT] Player is having sex. (ending)")
		CommonProperties.PlayerIsHavingSex = false
	endIf
endEvent

event OnUpdate()
	int playerArousal = Integrations.GetArousal(player)
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) == 0
	CommonProperties.PlayerHasCumOn = SexLab.CountCum(player) > 0
	if(playerArousal >= CommonProperties.SAHA_ArousalToApplyIMAD)
		player.AddSpell(CommonProperties.SexAddictionHighArousalIMAD)
	elseif(player.HasSpell(CommonProperties.SexAddictionHighArousalIMAD))
		player.RemoveSpell(CommonProperties.SexAddictionHighArousalIMAD)
	endIf
endEvent