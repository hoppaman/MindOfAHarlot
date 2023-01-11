Scriptname MoaH_MGEFHarlotCunning extends activemagiceffect  

Perk Property HarlotCunningPerk Auto

; When ability is removed it appears that mgef is removed before OnEffectFinish is ran
float mag = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(HarlotCunningPerk)
	mag = GetMagnitude()
	akTarget.ModAV("HealRate", mag * 0.5)
	akTarget.ModAV("StaminaRate", mag * 0.5)
	akTarget.ModAV("MagickaRate", mag * 0.5)
	akTarget.ModAV("Sneak", mag)
	akTarget.ModAV("PickPocket", mag)
	;akTarget.ModAV("PickPocketMod", mag)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotCunningPerk)
	akTarget.ModAV("HealRate", -mag * 0.5)
	akTarget.ModAV("StaminaRate", -mag * 0.5)
	akTarget.ModAV("MagickaRate", -mag * 0.5)
	akTarget.ModAV("Sneak", -mag)
	akTarget.ModAV("PickPocket", -mag)
endEvent