Scriptname MoaH_RefSanguine extends ReferenceAlias  

{ Script should be renamed to MoaH_RefSanguineIntroduction
}

MoaH_QuestIntroductionCourier Property IntroductionCourier Auto

event OnInit()
	
endEvent

event OnReset()
	Debug.Trace("[MoaH] Sanguine found.")
endEvent

event OnActivate(ObjectReference akActionRef)
	Debug.Notification("[MoaH] Sanguine is activated.")
	if(!IntroductionCourier.CourierMagicDone && !IntroductionCourier.DA14NightToRemember.IsCompleted())
		Debug.Trace("[MoaH] Player talking to sanguine starting courier.")
		IntroductionCourier.StartCourierMagic()
	endIf
endEvent

