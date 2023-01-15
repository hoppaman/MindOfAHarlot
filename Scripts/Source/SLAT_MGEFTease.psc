Scriptname SLAT_MGEFTease extends activemagiceffect  

; NOTE: This effect is tied to teasing spell and mgef

SLAT_QuestCommonProperties property CommonProperties auto

Idle Property MaleFondle1 Auto
Idle Property MaleFondle2 Auto

Idle Property FemaleFondle1 Auto
Idle Property FemaleFondle2 Auto
Idle Property FemaleFondle3 Auto

Idle Property GS371 Auto
Idle Property GS402 Auto
Idle Property GS403 Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	float duration = GetDuration()
	SexLabFramework SexLab = CommonProperties.SexLab
	Debug.Trace("[MoaH] Fondle starting with duration of " + duration)
	int gender = SexLab.GetGender(akTarget)
	if( gender == 0) ; is Male
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			COMMON_Utility.PlayThirdPersonAnimation(akTarget, MaleFondle1, duration)
		elseif(r == 1)
			COMMON_Utility.PlayThirdPersonAnimation(akTarget, MaleFondle2, duration)
		endIf
	elseif(gender == 1) ; female
		int r = Utility.RandomInt(0,2)
		; Seductive torso touching x2
		; Sassy body sway
		; Naughty hand gesture
		; Seductive touching
		; Sexy laying on stomach
		; Shy butt sway
		; Slow swaying x2
		; Seductive hip touch
		; Seductive breast massage
		; Stand pussy rub
		; Hands caress body
		; hip sway
		; Hands caress breasts
		; Slow up/down hip sway
		; Breast cup hip tease
		; Hands on Hips Twirl
		; Laydown Ass Fingering
		
		; Stand Still Slow Shift
		; 312
		; 337
		; 344
		
		; Slow right breast caress
		; Hey hey
		; Squat boob shake
		; Bend over super butt shake
		; Face down ass up superb tease
		; Hands flat hip tease
		; Side to side dance
		; All fours worship
		; Pray
		; You can stare
		; I said you can stare
		; 310
		; 324
		; 335
		; 369
		; 371
		; 402
		; 403
		
		; 451 - casting idle
		
		; 455 - exhausted sitting
		if(r == 0)
			COMMON_Utility.PlayThirdPersonAnimation(akTarget, GS371, duration)
		elseif(r == 1)
			COMMON_Utility.PlayThirdPersonAnimation(akTarget, GS402, duration)
		elseif(r == 2)
			COMMON_Utility.PlayThirdPersonAnimation(akTarget, GS403, duration)
		endIf
	else
		Debug.Trace("[MoaH] Creature cannot fondle.")
	endIf
	Utility.Wait(1.5)

	UpdateArousal()
	
	Debug.Trace("[MoaH] sending spanker ")
	Int ModSpankEvent = ModEvent.Create("STA_DoRandomNpcSpank")
	ModEvent.PushFloat(ModSpankEvent, 15) ; Timeout
	ModEvent.PushBool(ModSpankEvent, true) ; allow furniture spank
	ModEvent.Send(ModSpankEvent)
	if(duration > 5.0)
		RegisterForUpdate(3.0)
	endIf
endEvent

function UpdateArousal()
	SexLabFramework SexLab = CommonProperties.SexLab
	Actor akTarget = GetTargetActor()
	sslBaseVoice voice = SexLab.PickVoice(akTarget)
	Int ModArousalEvent = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(ModArousalEvent, akTarget)
    ModEvent.PushFloat(ModArousalEvent, 2)
    ModEvent.Send(ModArousalEvent)
	voice.PlayMoanEx(akTarget)
endFunction

event OnUpdate()
	UpdateArousal()
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	Debug.Notification("[MoaH] Fondle end")
	UnregisterForUpdate()
endEvent