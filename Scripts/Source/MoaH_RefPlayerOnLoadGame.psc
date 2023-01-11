Scriptname MoaH_RefPlayerOnLoadGame extends ReferenceAlias  

Event OnPlayerLoadGame()
	(GetOwningQuest() as MoaH_QuestBase).OnLoadGame()
endEvent