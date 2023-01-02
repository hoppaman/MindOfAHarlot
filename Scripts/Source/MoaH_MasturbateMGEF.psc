Scriptname MoaH_MasturbateMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	SexLabFramework SexLab = CommonProperties.SexLab
	Debug.Trace("[MoaH] Masturbate starting.")
	MOAH_Utility.Masturbate(akCaster)
endEvent