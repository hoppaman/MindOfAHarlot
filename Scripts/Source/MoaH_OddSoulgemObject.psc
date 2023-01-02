Scriptname MoaH_OddSoulgemObject extends ObjectReference  

Actor Property PlayerRef Auto
SexLabFramework Property SexLab Auto
Actor Property TaraSpirit Auto
MoaH_IntroductionQuest Property IntroductionQuest Auto
bool done = false

Event OnActivate(ObjectReference akActionRef)
	Debug.MessageBox("As you touch the soulgem sensation hits your mind. Its all a blur and you can't make it out. As it fades your body tingles it appears that you have triggered a trap. Something in the soulgem is guiding you its taking over.")
	Disable();
	TriggerSex(PlayerRef)
EndEvent

Function TriggerSex(Actor akActor)
	If SexLab.IsValidActor(akActor)
		sslBaseAnimation Animation1 = SexLab.GetAnimationByName("Leito Female Dildo Anal")

		IF (Animation1 == None)
			Debug.Trace("Required animation <leito> are not installed.")
			Return
		EndIf
		
		sslBaseAnimation[] AnimationList = new sslBaseAnimation[1]
		AnimationList[0] = Animation1
		sslThreadModel thread = SexLab.NewThread()
		thread.AddActor(akActor)
		thread.SetAnimations(AnimationList)
		Thread.DisableBedUse(false)
		string hook = "MoaH_introduction"
		thread.SetHook(hook)
		Debug.Trace("Hook is " + hook)
		RegisterForModEvent(hook, "AnimationEnd")
		RegisterForModEvent(hook, "OrgasmStart")
		thread.StartThread()
	EndIf
EndFunction

event OrgasmStart(int ThreadID, bool HasPlayer)
	Debug.Trace("OrgasmStart")
	SummonTara(ThreadID)
endEvent

event AnimationEnd(int ThreadID, bool HasPlayer)
	Debug.Trace("AnimationEnd")
	sslThreadController Thread = SexLab.GetController(ThreadID)
	
	Actor[] Positions = Thread.Positions
	
	If ((Positions[1].GetItemCount(Self) > 0)&&(!HasPlayer))
		Positions[1].DropObject(Self,1)
		SetActorOwner(NONE)
	EndIf
	
	SummonTara(ThreadID)
	
endEvent

function SummonTara(int ThreadID)
	If(!done)
		done = true
		Debug.MessageBox("Sudden light bursts from the gem and it shatters in your hand. You gain control but what you just have experienced was stronger that you ever have had.")
		sslThreadController Thread = SexLab.GetController(ThreadID)
		Thread.EndAnimation(true)
		IntroductionQuest.SetObjectiveCompleted(30)
		; TODO: set player to pose and hold it
	EndIf
endFunction