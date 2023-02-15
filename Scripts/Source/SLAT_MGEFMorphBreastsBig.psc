Scriptname SLAT_MGEFMorphBreastsBig extends activemagiceffect  

SLAT_QuestCommonProperties Property CommonProperties Auto

bool Property NegativeEffect = false Auto
{ This negates magnitude. }

event OnEffectStart(Actor akTarget, Actor akActor)
	Faction morphFaction = CommonProperties.MorphScoreBigBreasts
	string morphFile = CommonProperties.BodyMorphsBigBreastsFile
	float amountToMorph = GetMagnitude()
	if NegativeEffect
		amountToMorph = amountToMorph * -1.0
	endIf
	COMMON_MorphUtility.ApplyMorph(akTarget, morphFaction, morphFile, amountToMorph)
endEvent

; event OnEffectFinish(Actor akTarget, Actor akActor)
; endEvent