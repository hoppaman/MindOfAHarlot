Scriptname MoaH_IntroductionStarterObject extends ObjectReference  

MoaH_CommonProperties Property CommonProperties  Auto

Event OnActivate(ObjectReference akActionRef)
	Debug.Trace("[MoaH] introduction starter picked up.")
	MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
	If(!IntroductionQuest.IsCompleted() && !IntroductionQuest.IsRunning())
		IntroductionQuest.Start()
	EndIf
EndEvent