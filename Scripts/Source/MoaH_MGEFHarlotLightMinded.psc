Scriptname MoaH_MGEFHarlotLightMinded extends activemagiceffect  

MoaH_QuestCommonProperties Property CommonProperties Auto

Perk Property HarlotLightMindedPerk01 Auto
Perk Property HarlotLightMindedPerk02 Auto
Perk Property HarlotLightMindedPerk03 Auto

float lastMagickaDebuff = 0.0

; When ability is removed it appears that mgef is removed before OnEffectFinish is ran
float mag = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	mag = GetMagnitude()
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
	
	int rank = akTarget.GetFactionRank(CommonProperties.HarlotStagesFaction)
	
	if(rank == 3)
		if(akTarget.HasPerk(HarlotLightMindedPerk01))
			akTarget.RemovePerk(HarlotLightMindedPerk01)
		endif
		
		if(akTarget.HasPerk(HarlotLightMindedPerk02))
			akTarget.RemovePerk(HarlotLightMindedPerk02)
		endif
		
		if(!akTarget.HasPerk(HarlotLightMindedPerk03))
			akTarget.AddPerk(HarlotLightMindedPerk03)
		endif
	elseif(rank == 2)
		if(akTarget.HasPerk(HarlotLightMindedPerk01))
			akTarget.RemovePerk(HarlotLightMindedPerk01)
		endif
		
		if(akTarget.HasPerk(HarlotLightMindedPerk03))
			akTarget.RemovePerk(HarlotLightMindedPerk03)
		endif
		
		if(!akTarget.HasPerk(HarlotLightMindedPerk02))
			akTarget.AddPerk(HarlotLightMindedPerk02)
		endif
	else
		if(akTarget.HasPerk(HarlotLightMindedPerk03))
			akTarget.RemovePerk(HarlotLightMindedPerk03)
		endif
		
		if(akTarget.HasPerk(HarlotLightMindedPerk02))
			akTarget.RemovePerk(HarlotLightMindedPerk02)
		endif
		
		if(!akTarget.HasPerk(HarlotLightMindedPerk01))
			akTarget.AddPerk(HarlotLightMindedPerk01)
		endif
	endIf
endFunction

event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(akTarget.HasPerk(HarlotLightMindedPerk03))
		akTarget.RemovePerk(HarlotLightMindedPerk03)
	endif
	
	if(akTarget.HasPerk(HarlotLightMindedPerk02))
		akTarget.RemovePerk(HarlotLightMindedPerk02)
	endif
	
	if(akTarget.HasPerk(HarlotLightMindedPerk01))
		akTarget.RemovePerk(HarlotLightMindedPerk01)
	endif
	
	akTarget.ModAV("Destruction", mag)
	akTarget.ModAV("Magicka", lastMagickaDebuff * -1)
endEvent