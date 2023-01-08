Scriptname MoaH_HarlotPrettyMGEF extends activemagiceffect  

Perk Property HarlotPrettyPerk Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(HarlotPrettyPerk)
	float mag = GetMagnitude()
	akTarget.ModAV("Illusion", mag)
	akTarget.ModAV("Speechcraft", mag)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotPrettyPerk)
	float mag = GetMagnitude()
	akTarget.ModAV("Illusion", mag * -1)
	akTarget.ModAV("Speechcraft", mag * -1)
endEvent