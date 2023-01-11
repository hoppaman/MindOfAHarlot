Scriptname MoaH_ObjectIntroductionStarter extends ObjectReference  

MoaH_QuestCommonProperties Property CommonProperties  Auto

Event OnActivate(ObjectReference akActionRef)
	Debug.Trace("[MoaH] introduction starter picked up.")
	Quest IntroductionQuest = CommonProperties.IntroductionQuest
	If(!IntroductionQuest.IsCompleted() && !IntroductionQuest.IsRunning())
		IntroductionQuest.Start()
	EndIf
EndEvent