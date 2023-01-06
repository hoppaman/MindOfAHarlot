Scriptname MoaH_ManRef extends ReferenceAlias

MoaH_ManSeek owner = None
Actor FoundMan = None

event OnInit()
	Debug.Trace("[MoaH] Man seek start")
	if(owner.EventNameToSend == "")
		Debug.Trace("[MoaH] ignoring man seek. No event has been defined.")
		return
	endIf
	owner =(GetOwningQuest() as MoaH_ManSeek)
	FoundMan = Self.GetReference() as Actor
	if(FoundMan != None)
		int eventHandle = ModEvent.Create(owner.EventNameToSend)
		modEvent.PushForm(eventHandle, FoundMan)
		ModEvent.Send(eventHandle)
		owner.Stop()
	endIf
endEvent