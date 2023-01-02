Scriptname MoaH_FondleMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	SexLabFramework SexLab = CommonProperties.SexLab
	Debug.Trace("[MoaH] Fondle starting.")
	int gender = SexLab.GetGender(akCaster)
	if( gender == 0) ; is Male
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			Debug.SendAnimationEvent(akCaster, "Aroused_Male_Idle1")
		elseif(r == 1)
			Debug.SendAnimationEvent(akCaster, "Aroused_Male_Idle2")
		endIf
	elseif(gender == 1) ; female
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			Debug.SendAnimationEvent(akCaster, "Aroused_Idle1")
		elseif(r == 1)
			Debug.SendAnimationEvent(akCaster, "Aroused_Idle2")
		elseif(r == 2)
			Debug.SendAnimationEvent(akCaster, "Aroused_Tease")
		endIf
	else
		Debug.Trace("[MoaH] Creature cannot fondle.")
	endIf
	Utility.Wait(0.4)
	sslBaseVoice voice = SexLab.PickVoice(akCaster)
	voice.PlayMoanEx(akCaster)
	
endEvent