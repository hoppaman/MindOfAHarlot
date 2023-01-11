Scriptname MoaH_MGEFHarlotLongNails extends activemagiceffect  

Perk Property HarlotLongNailsPerk Auto

; When ability is removed it appears that mgef is removed before OnEffectFinish is ran
float mag = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(HarlotLongNailsPerk)
	mag = GetMagnitude()
	akTarget.ModAV("TwoHanded", mag * -1)
	akTarget.ModAV("HeavyArmor", mag * -1)
	akTarget.ModAV("OneHanded", mag * -0.5)
	akTarget.ModAV("LightArmor", mag * -0.5)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotLongNailsPerk)
	akTarget.ModAV("TwoHanded", mag)
	akTarget.ModAV("HeavyArmor", mag)
	akTarget.ModAV("OneHanded", mag * 0.5)
	akTarget.ModAV("LightArmor", mag * 0.5)
endEvent