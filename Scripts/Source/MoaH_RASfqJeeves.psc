Scriptname MoaH_RASfqJeeves extends ReferenceAlias  

event OnActivate(ObjectReference akActionRef)
	Debug.Notification("[MoaH] Jeeves is activated.")
	if akActionRef == Game.GetPlayer()
		GetActorReference().ShowBarterMenu()
	endIf
endEvent