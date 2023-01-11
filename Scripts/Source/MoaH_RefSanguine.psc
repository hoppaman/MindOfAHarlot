Scriptname MoaH_RefSanguine extends ReferenceAlias  

event OnInit()
	Debug.Trace("[MoaH] Sanguine found.")
	;Debug.MessageBox("[MoaH] Evil raises.")
	Actor sanguine = GetActorReference()	
endEvent

event OnActivate(ObjectReference akActionRef)
	Debug.Notification("[MoaH] Sanguine is activated.")
	; Do Courrier magic
endEvent
