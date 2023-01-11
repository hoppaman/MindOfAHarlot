Scriptname MoaH_MGEFHarlotFragile extends activemagiceffect  

float lastHealthDebuff = 0.0
float lastStaminaDebuff = 0.0

Perk Property HarlotFragilePerk Auto

; When ability is removed it appears that mgef is removed before OnEffectFinish is ran
float mag = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	mag = GetMagnitude()
	akTarget.AddPerk(HarlotFragilePerk)
	akTarget.ModAV("CarryWeight", mag * -1)
	UpdateStats(akTarget)
	; Pretty killer 
	; TODO: if possible trigger this on levelup? Except sacrosanct adds base health
	RegisterForUpdate(30.0)
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
	lastHealthDebuff = UpdateCappedStat(akTarget, "Health", 100.0, lastHealthDebuff)
	lastStaminaDebuff = UpdateCappedStat(akTarget, "Stamina", 100.0, lastStaminaDebuff)
endFunction

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotFragilePerk)
	akTarget.ModAV("CarryWeight", mag)
	akTarget.ModAV("Health", lastHealthDebuff * -1)
	akTarget.ModAV("Stamina", lastStaminaDebuff * -1)
endEvent