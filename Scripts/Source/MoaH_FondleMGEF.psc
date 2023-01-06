Scriptname MoaH_FondleMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto
MoaH_Utility property MUtility auto

Idle Property MaleFondle1 Auto
Idle Property MaleFondle2 Auto

Idle Property FemaleFondle1 Auto
Idle Property FemaleFondle2 Auto
Idle Property FemaleFondle3 Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	float duration = GetDuration()
	SexLabFramework SexLab = CommonProperties.SexLab
	Debug.Trace("[MoaH] Fondle starting with duration of " + duration)
	int gender = SexLab.GetGender(akTarget)
	if( gender == 0) ; is Male
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			MUtility.PlayThirdPersonAnimation(akTarget, MaleFondle1, duration)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akTarget, MaleFondle2, duration)
		endIf
	elseif(gender == 1) ; female
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			MUtility.PlayThirdPersonAnimation(akTarget, FemaleFondle1, duration)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akTarget, FemaleFondle2, duration)
		elseif(r == 2)
			MUtility.PlayThirdPersonAnimation(akTarget, FemaleFondle3, duration)
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
	Actor[] actors = MUtility.FindAdultActorsNear(akTarget, 4000.0)
	if(actors.Length > 0)
		int randomIndex = Utility.RandomInt(0, actors.Length - 1)
		Actor randomActor = (actors[randomIndex] as Actor)
		Debug.Trace("[MoaH] sending spanker " + randomActor.GetDisplayName())
		Int ModSpankEvent = ModEvent.Create("STA_DoNpcSpankSpecific")
		ModEvent.PushFloat(ModSpankEvent, 30) ; Timeout
		ModEvent.PushForm(ModSpankEvent, randomActor) ; Spanker
		ModEvent.PushBool(ModSpankEvent, true) ; Comment
		ModEvent.Send(ModSpankEvent)
	endIf
	
endEvent