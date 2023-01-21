Scriptname SLAT_MGEFTease extends activemagiceffect  

; NOTE: This effect is tied to teasing spell and mgef

SLAT_QuestCommonProperties property CommonProperties auto

Idle Property MaleFondle1 Auto
Idle Property MaleFondle2 Auto

; Female
Idle Property GS92 Auto
{Seductive torso touching}
Idle Property GS105 Auto
{Seductive touching}
Idle Property GS122 Auto
{Seductive torso touching}
Idle Property GS153 Auto
{Seductive hip touch}
Idle Property GS156 Auto
{Seductive breast massage}
Idle Property GS158 Auto
{Seductive sway}
Idle Property GS170 Auto
{Stand pussy rub}
Idle Property GS174 Auto
{Hands caress body}
Idle Property GS185 Auto
{Hands caress breasts}
Idle Property GS198 Auto
{Breast cup hip tease}
Idle Property GS229 Auto
{Slow right breast caress}
Idle Property GS259 Auto
{Hands flat hip tease}
Idle Property GS300 Auto
{You can stare}
Idle Property GS303 Auto
{I said you can stare}
Idle Property GS371 Auto
{Masturbating one hand behind}

Idle[] FemaleFondles

Actor target;

event OnInit()
	FemaleFondles = new Idle[14]
	FemaleFondles[0] = GS92
	FemaleFondles[1] = GS105
	FemaleFondles[2] = GS122
	FemaleFondles[3] = GS153
	FemaleFondles[4] = GS156
	FemaleFondles[5] = GS158
	FemaleFondles[6] = GS170
	FemaleFondles[7] = GS174
	FemaleFondles[8] = GS198
	FemaleFondles[9] = GS229
	FemaleFondles[10] = GS259
	FemaleFondles[11] = GS300
	FemaleFondles[12] = GS303
	FemaleFondles[13] = GS371
endEvent

event OnEffectStart(Actor akTarget, Actor akCaster)
	target = akTarget
	float duration = GetDuration()
	SexLabFramework SexLab = CommonProperties.SexLab
	Debug.Trace("[MoaH] Tease starting with duration of " + duration)
	int gender = SexLab.GetGender(target)
	if( gender == 0) ; is Male
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			COMMON_Utility.PlayThirdPersonAnimation(target, MaleFondle1, duration)
		elseif(r == 1)
			COMMON_Utility.PlayThirdPersonAnimation(target, MaleFondle2, duration)
		endIf
	elseif(gender == 1) ; female
		int r = Utility.RandomInt(0,FemaleFondles.Length - 1)
		
		Idle chosenFondle = FemaleFondles[r]
			
		COMMON_Utility.PlayThirdPersonAnimation(target, chosenFondle, duration)
		
	else
		Debug.Trace("[MoaH] Creature cannot tease.")
	endIf
	Utility.Wait(1.5)

	UpdateArousal()
	if(target == Game.GetPlayer())
		Debug.Trace("[MoaH] sending spanker ")
		Int ModSpankEvent = ModEvent.Create("STA_DoRandomNpcSpank")
		ModEvent.PushFloat(ModSpankEvent, 15) ; Timeout
		ModEvent.PushBool(ModSpankEvent, true) ; allow furniture spank
		ModEvent.PushFloat(ModSpankEvent, 1.5)
		ModEvent.Send(ModSpankEvent)
		
		CommonProperties.PlayerIsTeasing = true
	endIf
	
	if(duration > 5.0)
		RegisterForUpdate(3.0)
	endIf
endEvent

function UpdateArousal()
	SexLabFramework SexLab = CommonProperties.SexLab
	
	sslBaseVoice voice = SexLab.PickVoice(target)
	Int ModArousalEvent = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(ModArousalEvent, target)
    ModEvent.PushFloat(ModArousalEvent, 2)
    ModEvent.Send(ModArousalEvent)
	voice.PlayMoanEx(target)
endFunction

event OnUpdate()
	UpdateArousal()
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	Debug.Notification("[MoaH] Teasing end")
	;UnregisterForUpdate()
	if(akTarget == Game.GetPlayer())
		CommonProperties.PlayerIsTeasing = false
	endIf
endEvent