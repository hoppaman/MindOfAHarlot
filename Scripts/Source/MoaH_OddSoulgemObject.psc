Scriptname MoaH_OddSoulgemObject extends ObjectReference  

MoaH_CommonProperties property CommonProperties auto

bool done = false

Event OnActivate(ObjectReference akActionRef)
	Actor PlayerRef = CommonProperties.PlayerRef
	Utility.Wait(0.2)
	TriggerSex(PlayerRef)
	Debug.MessageBox("As you touch the soulgem sensation hits your mind. Its all a blur and you can't make it out. As it fades your body tingles it appears that you have triggered a trap. Something in the soulgem is guiding you its taking over.")
	
EndEvent

Function TriggerSex(Actor akActor)
	SexLabFramework SexLab = CommonProperties.SexLab
	If SexLab.IsValidActor(akActor)
		sslBaseAnimation Animation1 = SexLab.GetAnimationByName("Leito Female Dildo Vaginal")

		IF (Animation1 == None)
			Debug.Trace("[MoaH] Required animation <leito> are not installed.")
		EndIf
		
		sslBaseAnimation[] AnimationList = new sslBaseAnimation[1]
		AnimationList[0] = Animation1
		sslThreadModel thread = SexLab.NewThread()
		thread.AddActor(akActor)
		thread.SetAnimations(AnimationList)
		Thread.DisableBedUse(true)
		; hook format Hook<animation event>_<hook name>
		string hookName = "MoaHIntroduction"
		string hookAnimationEnd = "HookAnimationEnd_"+hookName
		string hookOrgasmStart = "HookOrgasmStart_"+hookName
		thread.SetHook(hookName)
		Debug.Trace("[MoaH] starting with hooks " + hookAnimationEnd + " " + hookOrgasmStart)
		RegisterForModEvent(hookAnimationEnd, "AnimationEnd")
		RegisterForModEvent(hookOrgasmStart, "OrgasmStart")
		thread.StartThread()
	else
		Debug.Trace("[MoaH] Player was not valid")
	EndIf
EndFunction

event OrgasmStart(int ThreadID, bool HasPlayer)
	Debug.Trace("[MoaH] OrgasmStart")
	SummonTara(ThreadID)
endEvent

event AnimationEnd(int ThreadID, bool HasPlayer)
	Debug.Trace("[MoaH] AnimationEnd")
	SexLabFramework SexLab = CommonProperties.SexLab
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
		SexLabFramework SexLab = CommonProperties.SexLab
		Actor PlayerRef = CommonProperties.PlayerRef
		MoaH_HarlotPerk HarlotPerk = CommonProperties.HarlotPerk
		MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
		if(!PlayerRef.HasPerk(HarlotPerk))
			PlayerRef.AddPerk(HarlotPerk)
		endIf
		Debug.MessageBox("Sudden light bursts from the gem and it shatters in your hand. You gain control but what you just have experienced was stronger that you ever have had.")
		sslThreadController Thread = SexLab.GetController(ThreadID)
		Thread.EndAnimation(true)
		Disable()
		Actor TarasSpirit = PlaceActorAtMe(CommonProperties.TarasSpirit)
		TarasSpirit.SetLookAt(PlayerRef, false)
		IntroductionQuest.SetObjectiveCompleted(30)
		CommonProperties.Tara = TarasSpirit
		Utility.Wait(1.0)
		TarasSpirit.ClearLookAt()
		; TODO: set player to pose and hold it
	EndIf
endFunction