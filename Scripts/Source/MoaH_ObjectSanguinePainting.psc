Scriptname MoaH_ObjectSanguinePainting extends ObjectReference  

MoaH_QuestCommonProperties Property CommonProperties  Auto  

Event OnActivate(ObjectReference akActionRef)
	Actor player = Game.GetPlayer()
	if(CommonProperties.MoaHSanguineRef)
		Actor sanguine = CommonProperties.MoaHSanguineRef.GetActorRef()
		if(sanguine.IsEnabled())
			sanguine.Disable(true)
		else
			sanguine.Enable(true)
		endIf
	else
		Debug.Notification("[MoaH] Sanguine cannot be reached.")
	endIf
endEvent