Scriptname MoaH_MGEFFondle extends activemagiceffect  

MoaH_QuestCommonProperties property CommonProperties auto
MoaH_QuestUtility property MUtility auto

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
			MUtility.PlayThirdPersonAnimation(akTarget, MaleFondle1, duration)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akTarget, MaleFondle2, duration)
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
			MUtility.PlayThirdPersonAnimation(akTarget, GS371, duration)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akTarget, GS402, duration)
		elseif(r == 2)
			MUtility.PlayThirdPersonAnimation(akTarget, GS403, duration)
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
	
	Debug.Trace("[MoaH] sending spanker ")
	Int ModSpankEvent = ModEvent.Create("STA_DoRandomNpcSpank")
	ModEvent.PushFloat(ModSpankEvent, 15) ; Timeout
	ModEvent.PushBool(ModSpankEvent, true) ; allow furniture spank
	ModEvent.Send(ModSpankEvent)
	
endEvent