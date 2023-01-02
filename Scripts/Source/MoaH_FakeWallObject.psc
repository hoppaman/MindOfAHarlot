Scriptname MoaH_FakeWallObject extends ObjectReference  

MoaH_CommonProperties property CommonProperties auto

Event OnActivate(ObjectReference akActionRef)
	MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
	if (!IntroductionQuest.IsObjectiveCompleted(20))
		Debug.Notification("As you touch the " + GetDisplayName() +". It begins to fade.")
		Disable(true)
		Utility.Wait(0.3)
		IntroductionQuest.SetCurrentStageID(80)
		IntroductionQuest.SetObjectiveCompleted(20)
	EndIF
EndEvent