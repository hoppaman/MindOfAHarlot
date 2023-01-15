Scriptname SLAT_MGEFMasturbate extends activemagiceffect  


event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Masturbate starting.")
	COMMON_Utility.Masturbate(akTarget)
	; TODO: listen for sexlab and dispel when it ends
endEvent