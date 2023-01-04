Scriptname MoaH_PlayerKicker extends ReferenceAlias  

Event OnPlayerLoadGame()
	(GetOwningQuest() as MoaH_QuestBase).OnLoadGame()
endEvent