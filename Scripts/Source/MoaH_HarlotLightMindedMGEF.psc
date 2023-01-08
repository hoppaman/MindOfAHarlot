Scriptname MoaH_HarlotLightMindedMGEF extends activemagiceffect  

Perk Property HarlotLightMindedPerk Auto

float lastMagickaDebuff = 0.0

; When ability is removed it appears that mgef is removed before OnEffectFinish is ran
float mag = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	mag = GetMagnitude()
	akTarget.AddPerk(HarlotLightMindedPerk)
	akTarget.ModAV("Destruction", mag * -1)
	UpdateStats(akTarget)
	; Pretty killer 
	; TODO: if possible trigger this on levelup and read book?
	RegisterForUpdate(30)
endEvent

event OnUpdate()
	Actor akTarget = GetTargetActor()
	if(!akTarget.IsInCombat())
		UpdateStats(akTarget)
	endIf
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
	akTarget.ModAV("Destruction", mag)
	akTarget.ModAV("Magicka", lastMagickaDebuff * -1)
endEvent