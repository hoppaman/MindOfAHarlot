Scriptname MoaH_HarlotMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto
Topic Property OtherSayTopic Auto
int lastUpdateStage = 0
float lastUpdateTime = 0.0

bool stage1ToStage2Passed = false
bool stage2ToStage3Passed = false

event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Harlot status starting.")
	RegisterForUpdateGameTime(CommonProperties.HarlotScoreUpdateIntervalGameTime)
	RegisterForSleep()
	
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
	
	if(akTarget == CommonProperties.PlayerRef)
		Debug.MessageBox("Your body tingles and blood rushes. Every bit of you is throbbing. Something has happened to you.")
		if(!CommonProperties.ThoughtsQuest.IsRunning())
			CommonProperties.ThoughtsQuest.Start()
		endIf
	else
		akTarget.Say(OtherSayTopic)
	endIf
	lastUpdateTime = Utility.GetCurrentGameTime()
	; Do first update immediately
	Update()
endEvent

event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)

endEvent

Event OnSleepStop(bool abInterrupted)
	Update()
endEvent

event OnUpdateGameTime()
	Update()
endEvent

function Update()
	; As player can wait or sleep we cannot trust that Update hits always. Count the real time passed.
	float step = PapyrusUtil.ClampFloat((Utility.GetCurrentGameTime() - lastUpdateTime) * 24, CommonProperties.HarlotScoreUpdateIntervalGameTime, 48)
	lastUpdateTime = Utility.GetCurrentGameTime()
	Actor akTarget = GetTargetActor()

	int Score = UpdateScore(akTarget, step)
	
	if(CommonProperties.SettingDebugHarlot)
		Debug.Notification("[MoaH] Harlot score update on " + akTarget.GetDisplayName() + ". Current value " + Score)
	endIf
	;Debug.Notification("Your body is getting more sensitive.")
	UpdateKeywords(akTarget,Score)
	float progress = (Score as float)/(CommonProperties.HarlotScoreMaxRank as float)

	UpdateMorphs(akTarget, progress)
endFunction

int function UpdateScore(Actor akTarget, float updateStep)
	Faction HarlotScoreFaction = CommonProperties.HarlotScoreFaction
	int HarlotScoreMaxRank = CommonProperties.HarlotScoreMaxRank
	int Score = akTarget.GetFactionRank(HarlotScoreFaction)
	
	if(Score < HarlotScoreMaxRank)
		int Step = Math.Floor((updateStep / 24.0) * CommonProperties.HarlotScorePerDay)
		Score = Score + Step
		if(Score > HarlotScoreMaxRank)
			Step = Step + (HarlotScoreMaxRank - Score)
			Score = HarlotScoreMaxRank
		EndIf
	
		akTarget.ModFactionRank(HarlotScoreFaction, Step)
	endIf
	
	return Score
endFunction

function UpdateMorphs(Actor akTarget, float mod)
	MoaH_MorphUtility.MorphActor(akTarget, CommonProperties.SettingHarlotMorphFile, mod)
endFunction

function UpdateKeywords(Actor akTarget, int Score)
	MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
	int iqCSI = IntroductionQuest.GetCurrentStageID()
	; Update keywords
	Keyword DesireStage1 = CommonProperties.HarlotSexAddictionStage1Keyword
	Keyword DesireStage2 = CommonProperties.HarlotSexAddictionStage2Keyword
	Keyword DesireStage3 = CommonProperties.HarlotSexAddictionStage3Keyword
	if (!akTarget.HasKeyword(DesireStage3) && Score > 90) ; {HarlotScoreMaxRank*2/3}
		PO3_SKSEFunctions.AddKeywordToForm(akTarget, DesireStage3)
		PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage2)
		UpdateAbilities(akTarget,3)
	elseif(!akTarget.HasKeyword(DesireStage2) && Score > 40) ; {HarlotScoreMaxRank/2}
		PO3_SKSEFunctions.AddKeywordToForm(akTarget, DesireStage2)
		PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage1)
		UpdateAbilities(akTarget,2)
	else
		if (!akTarget.HasKeyword(DesireStage1)) 
			PO3_SKSEFunctions.AddKeywordToForm(akTarget, DesireStage1)
		endif
		if(akTarget.HasKeyword(DesireStage3))	
			PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage3)
		endif
		if(akTarget.HasKeyword(DesireStage2))
			PO3_SKSEFunctions.RemoveKeywordOnForm(akTarget, DesireStage2)
		endif
		UpdateAbilities(akTarget,1)
	endIf
endFunction

function UpdateAbilities(Actor akTarget, int stage)
	if(lastUpdateStage == stage) 
		return
	endif
	
	if(!stage1ToStage2Passed && lastUpdateStage == 1 && stage == 2)
		stage1ToStage2Passed = true
		Debug.MessageBox("My body is warm and tingling and its more difficult to concerntrate. I could swear something is happening with my body. Maybe I should ask Tara about this?")
	elseif(!stage2ToStage3Passed && lastUpdateStage == 2 && stage == 3)
		stage2ToStage3Passed = true
		Debug.MessageBox("My body is excited. My lips are sensitive and throbbing. I need to have someone inside me.")
	endif
	lastUpdateStage = stage
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
		akTarget.AddSpell(toEnable, false)
	endif
endfunction

event OnEffectFinish(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Harlot status ending. On " + akTarget.GetDisplayName())
	UnregisterForUpdateGameTime()
	UnregisterForSleep()
		
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
	
	if(akTarget.HasSpell(LongNails1))
		akTarget.RemoveSpell(LongNails1)
	endif
	if(akTarget.HasSpell(LongNails2))
		akTarget.RemoveSpell(LongNails2)
	endif
	if(akTarget.HasSpell(LongNails3))
		akTarget.RemoveSpell(LongNails3)
	endif
	
	if(akTarget.HasSpell(LightMinded1))
		akTarget.RemoveSpell(LightMinded1)
	endif
	if(akTarget.HasSpell(LightMinded2))
		akTarget.RemoveSpell(LightMinded2)
	endif
	if(akTarget.HasSpell(LightMinded3))
		akTarget.RemoveSpell(LightMinded3)
	endif
	
	if(akTarget.HasSpell(Pretty1))
		akTarget.RemoveSpell(Pretty1)
	endif
	if(akTarget.HasSpell(Pretty2))
		akTarget.RemoveSpell(Pretty2)
	endif
	if(akTarget.HasSpell(Pretty3))
		akTarget.RemoveSpell(Pretty3)
	endif
	
	if(akTarget.HasSpell(Fragile1))
		akTarget.RemoveSpell(Fragile1)
	endif
	if(akTarget.HasSpell(Fragile2))
		akTarget.RemoveSpell(Fragile2)
	endif
	if(akTarget.HasSpell(Fragile3))
		akTarget.RemoveSpell(Fragile3)
	endif
	
	if(akTarget.HasSpell(Cunning1))
		akTarget.RemoveSpell(Cunning1)
	endif
	if(akTarget.HasSpell(Cunning2))
		akTarget.RemoveSpell(Cunning2)
	endif
	if(akTarget.HasSpell(Cunning3))
		akTarget.RemoveSpell(Cunning3)
	endif
endEvent