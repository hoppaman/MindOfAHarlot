Scriptname MoaH_ObjectFakeWall extends ObjectReference  

MoaH_QuestCommonProperties property CommonProperties auto

Event OnActivate(ObjectReference akActionRef)
	Quest IntroductionQuest = CommonProperties.IntroductionQuest
	if (!IntroductionQuest.IsObjectiveCompleted(20))
		Debug.Notification("As you touch the " + GetDisplayName() +". It begins to fade.")
		Disable(true)
		Utility.Wait(0.3)
		IntroductionQuest.SetCurrentStageID(80)
		IntroductionQuest.SetObjectiveCompleted(20)
	EndIF
EndEvent