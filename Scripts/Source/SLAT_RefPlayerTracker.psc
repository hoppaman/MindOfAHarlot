Scriptname SLAT_RefPlayerTracker extends ReferenceAlias  

SLAT_QuestCommonProperties Property CommonProperties Auto

Faction Property slaNakedFaction Auto

event OnInit()
	Actor player = GetActorRef()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) == 0
	
	RegisterForUpdate(5);
endEvent

event OnUpdate()
	Actor player = GetActorRef()
	CommonProperties.PlayerIsNaked = player.GetFactionRank(slaNakedFaction) == 0
endEvent