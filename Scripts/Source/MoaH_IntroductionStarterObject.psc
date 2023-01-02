Scriptname MoaH_IntroductionStarterObject extends ObjectReference  

MoaH_IntroductionQuest Property IntroductionQuest  Auto

Event OnActivate(ObjectReference akActionRef)
	Debug.Trace("[MoaH] introduction starter picked up.")
	If(!IntroductionQuest.IsCompleted() && !IntroductionQuest.IsRunning())
		IntroductionQuest.Start()
	EndIf
EndEvent