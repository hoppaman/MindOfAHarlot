Scriptname MoaH_HarlotLightMindedMGEF extends activemagiceffect  

Perk Property HarlotLightMindedPerk Auto

float lastMagickaDebuff = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(HarlotLightMindedPerk)
	akTarget.ModAV("Destruction", GetMagnitude() * -1)
	UpdateStats(akTarget)
	; Pretty killer 
	; TODO: if possible trigger this on levelup and read book?
	RegisterForUpdate(1)
endEvent

event OnUpdate()
	UpdateStats(GetTargetActor())
endEvent

float function UpdateCappedStat(Actor akTarget, string stat, float cap, float lastStrength)
	akTarget.ModAV(stat, lastStrength * -1)
	float debuffStrength = -1 * (akTarget.GetBaseActorValue(stat) - cap)
	akTarget.ModAV(stat, debuffStrength)
	return debuffStrength
endFunction

function UpdateStats(Actor akTarget)
	; Remove old before update
	lastMagickaDebuff = UpdateCappedStat(akTarget, "Magicka", 100, lastMagickaDebuff)
endFunction

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotLightMindedPerk)
	akTarget.ModAV("Destruction", GetMagnitude())
	akTarget.ModAV("Magicka", lastMagickaDebuff * -1)
endEvent