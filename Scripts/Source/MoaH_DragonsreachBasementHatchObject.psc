Scriptname MoaH_DragonsreachBasementHatchObject extends ObjectReference  

MoaH_IntroductionQuest Property IntroductionQuest Auto


Event OnActivate(ObjectReference akActionRef)
	if (!IntroductionQuest.IsObjectiveCompleted(10))
		Debug.Notification("You manage to unlock the hatch and squeeze yourself into the hatch.")
		Utility.Wait(5.0)
		IntroductionQuest.SetObjectiveCompleted(10)
		IntroductionQuest.SetCurrentStageID(40)
	EndIf
EndEvent