Scriptname MoaH_FondleMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto
MoaH_Utility property MUtility auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	SexLabFramework SexLab = CommonProperties.SexLab
	Debug.Trace("[MoaH] Fondle starting.")
	int gender = SexLab.GetGender(akCaster)
	if( gender == 0) ; is Male
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			MUtility.PlayThirdPersonAnimation(akCaster, "Aroused_Male_Idle1", 8)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akCaster, "Aroused_Male_Idle2", 8)
		endIf
	elseif(gender == 1) ; female
		int r = Utility.RandomInt(0,2)
		if(r == 0)
			MUtility.PlayThirdPersonAnimation(akCaster, "Aroused_Idle1", 8)
		elseif(r == 1)
			MUtility.PlayThirdPersonAnimation(akCaster, "Aroused_Idle2", 8)
		elseif(r == 2)
			MUtility.PlayThirdPersonAnimation(akCaster, "Aroused_Tease", 8)
		endIf
	else
		Debug.Trace("[MoaH] Creature cannot fondle.")
	endIf
	Utility.Wait(1.5)
	sslBaseVoice voice = SexLab.PickVoice(akCaster)
	voice.PlayMoanEx(akCaster)
	
endEvent