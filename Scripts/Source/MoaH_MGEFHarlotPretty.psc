Scriptname MoaH_MGEFHarlotPretty extends activemagiceffect  

Perk Property HarlotPrettyPerk Auto

; When ability is removed it appears that mgef is removed before OnEffectFinish is ran
float mag = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(HarlotPrettyPerk)
	mag = GetMagnitude()
	akTarget.ModAV("Illusion", mag)
	akTarget.ModAV("Speechcraft", mag)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotPrettyPerk)
	akTarget.ModAV("Illusion", mag * -1)
	akTarget.ModAV("Speechcraft", mag * -1)
endEvent