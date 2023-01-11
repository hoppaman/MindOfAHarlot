Scriptname MoaH_MGEFMasturbate extends activemagiceffect  

MoaH_QuestCommonProperties property CommonProperties auto
MoaH_QuestUtility property MUtility auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Masturbate starting.")
	MUtility.Masturbate(akTarget)
endEvent