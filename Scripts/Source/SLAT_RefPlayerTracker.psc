Scriptname SLAT_RefPlayerTracker extends ReferenceAlias  

SLAT_QuestCommonProperties Property CommonProperties Auto

Faction Property slaNakedFaction Auto

SexLabFramework SexLab
Actor player

event OnInit()
	SexLab = SexLabUtil.GetAPI()
	player = GetActorRef()
endEvent

event OnReset()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) >= 0
	UnregisterForAllModEvents()
		
	RegisterForModEvent("AnimationStart", "OnSexLabAnimationStart")
	RegisterForModEvent("AnimationEnd", "OnSexLabAnimationEnd")
	
	UnregisterForUpdate()
	RegisterForUpdate(5)
endEvent

Event OnSexlabAnimationStart(string eventName, string strArg, float numArg, Form sender)
	Debug.Trace("[MoaH] SexLabAnimationStart")
	sslThreadController thread = SexLab.GetController(strArg as int)
	if(thread.hasPlayer)
		Debug.Trace("[SLAT] Player is having sex.")
		Debug.Notification("[SLAT] Player is having sex.")
		CommonProperties.PlayerIsHavingSex = true
	endIf
endEvent

Event OnSexlabAnimationEnd(string eventName, string strArg, float numArg, Form sender)
	Debug.Trace("[MoaH] SexLabAnimationEnd")
			
	sslThreadController thread = SexLab.GetController(strArg as int)
	if(thread.hasPlayer)
		Debug.Trace("[SLAT] Player is having sex. (ending)")
		Debug.Notification("[SLAT] Player is having sex. (ending)")
		CommonProperties.PlayerIsHavingSex = false
	endIf
endEvent

event OnUpdate()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) == 0
	CommonProperties.PlayerHasCumOn = SexLab.CountCum(player) > 0
endEvent