Scriptname MoaH_QuestIntroductionCourier extends Quest  

Bool Property ShouldDoCourierMagic = False Auto Hidden 
Bool Property CourierMagicDone = False Auto Hidden 
Bool Property CourierStarting = False Auto Hidden

Quest Property DA14NightToRemember Auto
WICourierScript Property CourierScript Auto

Book Property BasementNote Auto
Key Property BasementKey Auto

event OnInit()
	if(DA14NightToRemember.IsCompleted() && !courierMagicDone)
		Debug.Trace("[MoaH] DA14 completed starting courier")
		; Case when user has already completed night to remember
		StartCourierMagic()
	endIf
endEvent

function StartCourierMagic()
	if(!CourierStarting)	
		Debug.Trace("[MoaH] StartCourierMagic")
		UnregisterForUpdate()
		RegisterForUpdate(30.0)
		CourierStarting = true
	endIf
endFunction

event OnUpdate()
	if(!CourierScript.IsRunning() && !courierMagicDone)
		DoCourierMagic()
		UnregisterForUpdate()
	endIf
endEvent

function DoCourierMagic()
	Debug.Trace("[MoaH] DoCourierMagic")
	if(!courierMagicDone)
		CourierScript.addItemToContainer(BasementKey)
		CourierScript.addItemToContainer(BasementNote)
		courierMagicDone = true
		CompleteQuest()
	endIf
endFunction