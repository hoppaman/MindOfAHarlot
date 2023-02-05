Scriptname MoaH_RASfqPlayer extends ReferenceAlias  

MoaH_QuestCommonProperties Property CommonProperties auto

Actor player

event OnInit()
	player = GetActorReference()
	
	if(!player.IsInFaction(CommonProperties.SanguineStandingFaction))
		player.AddToFaction(CommonProperties.SanguineStandingFaction)
	endIf
endEvent