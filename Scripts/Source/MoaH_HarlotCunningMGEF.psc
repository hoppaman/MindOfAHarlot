Scriptname MoaH_HarlotCunningMGEF extends activemagiceffect  

Perk Property HarlotCunningPerk Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(HarlotCunningPerk)
	float mag = GetMagnitude()
	akTarget.ModAV("HealRate", mag)
	akTarget.ModAV("StaminaRate", mag)
	akTarget.ModAV("MagickaRate", mag)
	akTarget.ModAV("CombatHealthRegenMultMod", 1 + mag/10)
	akTarget.ModAV("Sneak", mag)
	akTarget.ModAV("PickPocket", mag)
	;akTarget.ModAV("PickPocketMod", mag)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(HarlotCunningPerk)
	float mag = GetMagnitude()
	akTarget.ModAV("HealRate", -mag)
	akTarget.ModAV("StaminaRate", -mag)
	akTarget.ModAV("MagickaRate", -mag)
	akTarget.ModAV("CombatHealthRegenMultMod", -1 - mag/10)
	akTarget.ModAV("Sneak", -mag)
	akTarget.ModAV("PickPocket", -mag)
endEvent