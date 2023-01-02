Scriptname MoaH_FakeWallObject extends ObjectReference  

MoaH_IntroductionQuest Property IntroductionQuest Auto

Event OnActivate(ObjectReference akActionRef)
	if (!IntroductionQuest.IsObjectiveCompleted(20))
		Debug.Notification("As you touch the " + GetDisplayName() +". It begins to fade.")
		Disable(true)
		Utility.Wait(0.3)
		IntroductionQuest.SetCurrentStageID(80)
		IntroductionQuest.SetObjectiveCompleted(20)
	EndIF
EndEvent