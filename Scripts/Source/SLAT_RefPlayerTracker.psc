Scriptname SLAT_RefPlayerTracker extends ReferenceAlias  

SLAT_QuestCommonProperties Property CommonProperties Auto

Faction Property slaNakedFaction Auto

SexLabFramework SexLab
Actor player

event OnInit()
	SexLab = SexLabUtil.GetAPI()
	player = GetActorRef()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) == 0
	UnregisterForAllModEvents()
	RegisterForModEvent("HookAnimationStart","SexLabAnimationStart")
	RegisterForModEvent("HookAnimationEnd","SexLabAnimationEnd")
	RegisterForUpdate(5);
endEvent

event SexLabAnimationStart(int tid, bool hasPlayer)
	if(hasPlayer)
		Debug.Trace("[SLAT] Player is having sex.")
		Debug.Notification("[SLAT] Player is having sex.")
		CommonProperties.PlayerIsHavingSex = true
	endIf
endEvent

event SexLabAnimationEnd(int tid, bool hasPlayer)
	if(hasPlayer)
		Debug.Trace("[SLAT] Player is having sex. (ending)")
		Debug.Notification("[SLAT] Player is having sex. (ending)")
		CommonProperties.PlayerIsHavingSex = false
	endIf
endEvent

event OnUpdate()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) == 0
	CommonProperties.PlayerHasCumOn = SexLab.CountCum(player) > 0
endEvent