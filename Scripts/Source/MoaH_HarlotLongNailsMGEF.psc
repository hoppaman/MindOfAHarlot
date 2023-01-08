Scriptname MoaH_HarlotLongNailsMGEF extends activemagiceffect  

Perk Property HarlotLongNailsPerk Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(HarlotLongNailsPerk)
	float mag = GetMagnitude()
	akTarget.ModAV("TwoHanded", mag * -1)
	akTarget.ModAV("HeavyArmor", mag * -1)
	akTarget.ModAV("OneHanded", mag * -0.5)
	akTarget.ModAV("LightArmor", mag * -0.5)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotLongNailsPerk)
	float mag = GetMagnitude()
	akTarget.ModAV("TwoHanded", mag)
	akTarget.ModAV("HeavyArmor", mag)
	akTarget.ModAV("OneHanded", mag * 0.5)
	akTarget.ModAV("LightArmor", mag * 0.5)
endEvent