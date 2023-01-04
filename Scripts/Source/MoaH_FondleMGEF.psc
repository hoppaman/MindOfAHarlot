Scriptname MoaH_FondleMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto
MoaH_Utility property MUtility auto
Keyword Property ActorTypeNPC auto

Idle Property MaleFondle1 Auto
Idle Property MaleFondle2 Auto

Idle Property FemaleFondle1 Auto
Idle Property FemaleFondle2 Auto
Idle Property FemaleFondle3 Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	SexLabFramework SexLab = CommonProperties.SexLab
	Debug.Trace("[MoaH] Fondle starting.")
	int gender = SexLab.GetGender(akTarget)
	if( gender == 0) ; is Male
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			MUtility.PlayThirdPersonAnimation(akTarget, MaleFondle1, 8)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akTarget, MaleFondle2, 8)
		endIf
	elseif(gender == 1) ; female
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			MUtility.PlayThirdPersonAnimation(akTarget, FemaleFondle1, 8)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akTarget, FemaleFondle2, 8)
		elseif(r == 2)
			MUtility.PlayThirdPersonAnimation(akTarget, FemaleFondle3, 8)
		endIf
	else
		Debug.Trace("[MoaH] Creature cannot fondle.")
	endIf
	Utility.Wait(1.5)
	sslBaseVoice voice = SexLab.PickVoice(akTarget)
	Int ModArousalEvent = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(ModArousalEvent, akTarget)
    ModEvent.PushFloat(ModArousalEvent, 5)
    ModEvent.Send(ModArousalEvent)
	voice.PlayMoanEx(akTarget)
	Actor[] actors = MiscUtil.ScanCellNPCs(akTarget, 2000, ActorTypeNPC)
	PapyrusUtil.RemoveActor(actors, akTarget)
	Debug.Notification("So many possible spankers around " + actors.Length)
	int index = 0
	While index < actors.Length
		Actor randomNPC = (actors[index] as Actor)
		if(CommonProperties.SexLab.GetGender(randomNPC) > 0)
			PapyrusUtil.RemoveActor(actors, randomNPC)
		else
			index + 1
		endIf
	endWhile
	if(actors.Length > 0)
		int randomIndex = Utility.RandomInt(0, actors.Length - 1)
		Actor randomActor = (actors[randomIndex] as Actor)
		Int ModSpankEvent = ModEvent.Create("STA_DoNpcSpankSpecific")
		ModEvent.PushFloat(ModSpankEvent, 5) ; Timeout
		ModEvent.PushForm(ModSpankEvent, randomActor) ; Spanker
		ModEvent.PushBool(ModSpankEvent, true) ; Comment
		ModEvent.Send(ModSpankEvent)
	endIf
	
endEvent