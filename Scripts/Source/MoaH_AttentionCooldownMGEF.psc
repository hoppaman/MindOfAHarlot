Scriptname MoaH_AttentionCooldownMGEF extends activemagiceffect  

event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdate(Utility.RandomFloat(10,30))
endEvent

event OnUpdate()
	Dispel()
endEvent

