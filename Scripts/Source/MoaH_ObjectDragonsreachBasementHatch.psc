Scriptname MoaH_ObjectDragonsreachBasementHatch extends ObjectReference  

MoaH_QuestCommonProperties property CommonProperties auto


Event OnActivate(ObjectReference akActionRef)
	Quest IntroductionQuest = CommonProperties.IntroductionQuest
	if (!IntroductionQuest.IsObjectiveCompleted(10))
		Debug.Notification("You manage to unlock the hatch and squeeze yourself into the hatch.")
		Utility.Wait(5.0)
		IntroductionQuest.SetObjectiveCompleted(10)
		IntroductionQuest.SetCurrentStageID(40)
	EndIf
EndEvent