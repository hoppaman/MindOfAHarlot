Scriptname SLAT_MGEFNailPolish extends activemagiceffect  

SLAT_QuestCommonProperties Property CommonProperties Auto

Armor Property NailsArmorItem auto

Keyword Property NailLengthKeyword auto

float StartDurability = 100.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	COMMON_Utility.AddKeyword(akTarget, NailLengthKeyword)	
	COMMON_Utility.AddKeyword(akTarget, CommonProperties.IsWearingNailPolish)
	akTarget.AddItem(NailsArmorItem, 1, false)
	akTarget.EquipItem(NailsArmorItem, true, true)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(akTarget.HasKeyword(NailLengthKeyword))
		COMMON_Utility.RemoveKeyword(akTarget, NailLengthKeyword)
	endIf
	if(akTarget.HasKeyword(CommonProperties.IsWearingNailPolish))
		COMMON_Utility.RemoveKeyword(akTarget, CommonProperties.IsWearingNailPolish)
	endIf
	akTarget.UnequipItem(NailsArmorItem, true, true)
	akTarget.RemoveItem(NailsArmorItem, 1, true, None)
endEvent