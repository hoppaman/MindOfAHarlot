Scriptname SLAT_MGEFMorphBodyHourglass extends activemagiceffect  

SLAT_QuestCommonProperties Property CommonProperties Auto

bool Property NegativeEffect = false Auto
{ This negates magnitude. }

int max = 127
int min = 0

event OnEffectStart(Actor akTarget, Actor akActor)
	Faction morphFaction = CommonProperties.MorphScoreHourglassBody
	string morphFile = CommonProperties.BodyMorphsHourglassBodyFile
	float amountToMorph = GetMagnitude()
	if NegativeEffect
		amountToMorph = amountToMorph * -1.0
	endIf
	COMMON_MorphUtility.ApplyMorph(akTarget, morphFaction, morphFile, amountToMorph)
endEvent

; event OnEffectFinish(Actor akTarget, Actor akActor)
; endEvent