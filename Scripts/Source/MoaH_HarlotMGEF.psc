Scriptname MoaH_HarlotMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Harlot status starting.")
	RegisterForUpdateGameTime(CommonProperties.HarlotScoreUpdateIntervalGameTime)
	akTarget.AddPerk(CommonProperties.HarlotPerk)
	; Will handle any possible ranks relation between harlots
	if(!akTarget.IsInFaction(CommonProperties.HarlotFaction))
		akTarget.AddToFaction(CommonProperties.HarlotFaction)
	endIf
	; Score of how well you have behaved as Harlot
	if(!akTarget.IsInFaction(CommonProperties.HarlotScoreFaction))
		akTarget.AddToFaction(CommonProperties.HarlotScoreFaction)
	endIf
	; Even this mgef doesn't handle sanguine favor add receiver to faction to start tracking
	if(!akTarget.IsInFaction(CommonProperties.SanguineStandingFaction))
		akTarget.AddToFaction(CommonProperties.SanguineStandingFaction)
	endIf
endEvent

event OnUpdateGameTime()
	Actor akTarget = GetTargetActor()

	int Score = UpdateScore(akTarget)
	
	if(CommonProperties.DebugHarlot)
		Debug.Notification("[MoaH] Harlot score update on " + akTarget.GetDisplayName() + ". Current value " + Score)
	endIf
	UpdateKeywords(akTarget,Score)
	UpdateAbilities(akTarget,Score)
endEvent

int function UpdateScore(Actor akTarget)
	Faction HarlotScoreFaction = CommonProperties.HarlotScoreFaction
	int HarlotScoreMaxRank = CommonProperties.HarlotScoreMaxRank
	int Score = akTarget.GetFactionRank(HarlotScoreFaction)
	
	if(Score < HarlotScoreMaxRank)
		int Step = CommonProperties.ScoreProgressStepPerInterval
		Score = Score + Step
		
		if(Score > HarlotScoreMaxRank)
			Step = Step-(Score-HarlotScoreMaxRank)
			Score = HarlotScoreMaxRank
		endIf
		akTarget.ModFactionRank(HarlotScoreFaction, Step)
	endIf
	
	
	return Score
endFunction

function UpdateKeywords(Actor akTarget, int Score)
	MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
	int iqCSI = IntroductionQuest.GetCurrentStageID()
	; Update keywords
	Keyword DesireStage1 = CommonProperties.DesireStage1
	Keyword DesireStage2 = CommonProperties.DesireStage2
	Keyword DesireStage3 = CommonProperties.DesireStage3
	if (!akTarget.HasKeyword(DesireStage3) && Score > 192) ; {HarlotScoreMaxRank*2/3}
		PO3_SKSEFunctions.AddKeywordToForm(akTarget, DesireStage3)
		PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage2)
		UpdateAbilities(akTarget,3)
	elseif(!akTarget.HasKeyword(DesireStage2) && Score > 128) ; {HarlotScoreMaxRank/2}
		PO3_SKSEFunctions.AddKeywordToForm(akTarget, DesireStage2)
		PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage1)
		UpdateAbilities(akTarget,3)
	elseif (!akTarget.HasKeyword(DesireStage1) || akTarget.HasKeyword(DesireStage3) || akTarget.HasKeyword(DesireStage2))
		if(CommonProperties.DebugHarlot)
			Debug.Notification("[MoaH] Clearing keywords")
		endIf
		PO3_SKSEFunctions.AddKeywordToForm(akTarget, DesireStage1)
		PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage2)
		PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage3)
		UpdateAbilities(akTarget,3)
	endIf
endFunction

function UpdateAbilities(Actor akTarget, int stage)
	Spell LongNails1 = CommonProperties.HarlotLongNailsStage1Ability
	Spell LongNails2 = CommonProperties.HarlotLongNailsStage2Ability
	Spell LongNails3 = CommonProperties.HarlotLongNailsStage3Ability
	Spell LightMinded1 = CommonProperties.HarlotLightMindedStage1Ability
	Spell LightMinded2 = CommonProperties.HarlotLightMindedStage2Ability
	Spell LightMinded3 = CommonProperties.HarlotLightMindedStage3Ability
	Spell Pretty1 = CommonProperties.HarlotPrettyStage1Ability
	Spell Pretty2 = CommonProperties.HarlotPrettyStage2Ability
	Spell Pretty3 = CommonProperties.HarlotPrettyStage3Ability
	Spell Fragile1 = CommonProperties.HarlotFragileStage1Ability
	Spell Fragile2 = CommonProperties.HarlotFragileStage2Ability
	Spell Fragile3 = CommonProperties.HarlotFragileStage3Ability
	Spell Cunning1 = CommonProperties.HarlotCunningStage1Ability
	Spell Cunning2 = CommonProperties.HarlotCunningStage2Ability
	Spell Cunning3 = CommonProperties.HarlotCunningStage3Ability
	
	if(stage == 1)
		SwitchSpell(akTarget, Cunning1, Cunning2, Cunning3)
		SwitchSpell(akTarget, Fragile1, Fragile2, Fragile3)
		SwitchSpell(akTarget, Pretty1, Pretty2, Pretty3)
		SwitchSpell(akTarget, LightMinded1, LightMinded2, LightMinded3)
		SwitchSpell(akTarget, LongNails1, LongNails2, LongNails3)
	elseif(stage == 2)
		SwitchSpell(akTarget, Cunning2, Cunning1, Cunning3)
		SwitchSpell(akTarget, Fragile2, Fragile1, Fragile3)
		SwitchSpell(akTarget, Pretty2, Pretty1, Pretty3)
		SwitchSpell(akTarget, LightMinded2, LightMinded1, LightMinded3)
		SwitchSpell(akTarget, LongNails2, LongNails1, LongNails3)
	elseif(stage == 3)
		SwitchSpell(akTarget, Cunning3, Cunning1, Cunning2)
		SwitchSpell(akTarget, Fragile3, Fragile1, Fragile2)
		SwitchSpell(akTarget, Pretty3, Pretty1, Pretty2)
		SwitchSpell(akTarget, LightMinded3, LightMinded1, LightMinded2)
		SwitchSpell(akTarget, LongNails3, LongNails1, LongNails2)
	endif
endFunction

function SwitchSpell(Actor akTarget, Spell toEnable, Spell disable1, Spell disable2)
	if(akTarget.HasSpell(disable1))
		akTarget.RemoveSpell(disable1)
	endif
	if(akTarget.HasSpell(disable2))
		akTarget.RemoveSpell(disable2)
	endif
	if(!akTarget.HasSpell(toEnable))
		akTarget.AddSpell(toEnable)
	endif
endfunction

event OnEffectFinish(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Harlot status ending. On " + akTarget.GetDisplayName())
	akTarget.RemovePerk(CommonProperties.HarlotPerk)
	UnregisterForUpdateGameTime()
endEvent