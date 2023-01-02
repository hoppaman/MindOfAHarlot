Scriptname MoaH_MasturbateMGEF extends activemagiceffect  

SexLabFramework Property SexLab Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Masturbate starting.")
	SexLab.QuickStart(akCaster)
endEvent