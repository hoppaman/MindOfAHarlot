Scriptname MoaH_SanguineRef extends ReferenceAlias  

event OnInit()
	Debug.Trace("[MoaH] Sanguine found.")
	Debug.MessageBox("[MoaH] Evil raises.")
	Actor sanguine = GetActorReference()
	
endEvent