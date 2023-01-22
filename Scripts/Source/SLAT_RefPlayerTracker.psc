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
		CommonProperties.PlayerIsHavingSex = true
	endIf
endEvent

event SexLabAnimationEnd(int tid, bool hasPlayer)
	if(hasPlayer)
		CommonProperties.PlayerIsHavingSex = true
	endIf
endEvent

event OnUpdate()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) == 0
	CommonProperties.PlayerHasCumOn = SexLab.CountCum(player) > 0
endEvent