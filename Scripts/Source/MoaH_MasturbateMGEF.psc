Scriptname MoaH_MasturbateMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto
MOAH_Utility property MUtility auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Masturbate starting.")
	MUtility.Masturbate(akTarget)
endEvent