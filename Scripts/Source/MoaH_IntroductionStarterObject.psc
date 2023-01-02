Scriptname MoaH_IntroductionStarterObject extends ObjectReference  

MoaH_IntroductionQuest Property IntroductionQuest  Auto

Event OnActivate(ObjectReference akActionRef)
	If(!IntroductionQuest.IsCompleted() && !IntroductionQuest.IsRunning())
		IntroductionQuest.Start()
	EndIf
EndEvent