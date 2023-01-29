Scriptname MoaH_MGEFHarlot extends activemagiceffect  

MoaH_QuestCommonProperties property CommonProperties auto


Topic Property OtherSayTopic Auto
int lastUpdateStage = 0
float lastUpdateTime = 0.0

Actor target
bool stage1ToStage2Passed = false
bool stage2ToStage3Passed = false
event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Harlot status starting.")
	target = akTarget
	RegisterForUpdateGameTime(CommonProperties.HarlotScoreUpdateIntervalGameTime)
	RegisterForSleep()
	
	; Will handle any possible ranks relation between harlots
	if(!target.IsInFaction(CommonProperties.HarlotFaction))
		target.AddToFaction(CommonProperties.HarlotFaction)
	endIf
	; Score of how well you have behaved as Harlot
	if(!target.IsInFaction(CommonProperties.HarlotScoreFaction))
		target.AddToFaction(CommonProperties.HarlotScoreFaction)
	endIf
	
	if(!target.IsInFaction(CommonProperties.HarlotBodyMorphFaction))
		target.AddToFaction(CommonProperties.HarlotBodyMorphFaction)
	endIf
	
	if(!target.IsInFaction(CommonProperties.HarlotBreastMorphFaction))
		target.AddToFaction(CommonProperties.HarlotBreastMorphFaction)
	endIf
	
	; Even this mgef doesn't handle sanguine favor add receiver to faction to start tracking
	if(!target.IsInFaction(CommonProperties.SanguineStandingFaction))
		target.AddToFaction(CommonProperties.SanguineStandingFaction)
	endIf
	
	if(target == Game.GetPlayer())
		Debug.MessageBox("Your body tingles and blood rushes. Every bit of you is throbbing. Something has happened to you.")
		; TODO: MoaH module
		;if(!CommonProperties.ThoughtsQuest.IsRunning())
		;	CommonProperties.ThoughtsQuest.Start()
		;endIf
	else
		target.Say(OtherSayTopic)
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
	Actor akTarget = target
	bool isPlayer = akTarget == Game.GetPlayer()
	; As player can wait or sleep we cannot trust that Update hits always. Count the real time passed.
	float step = PapyrusUtil.ClampFloat((Utility.GetCurrentGameTime() - lastUpdateTime) * 24, CommonProperties.HarlotScoreUpdateIntervalGameTime, 48)
	lastUpdateTime = Utility.GetCurrentGameTime()
	
	int AddictionScore = UpdateAddictionScore(akTarget, step)
	
	;Debug.Notification("Your body is getting more sensitive.")
	UpdateFactionRanks(akTarget,AddictionScore)
	float progress = (AddictionScore as float)/(CommonProperties.HarlotScoreMaxRank as float)

	if(isPlayer)
		UpdateArousalBoundaries(AddictionScore)
		CommonProperties.PlayerHarlotAddictionProgressFloat.SetValue(progress)
		CommonProperties.PlayerHarlotMorphsProgressFloat.SetValue(progress)
	endif

	UpdateMorphs(akTarget, step)
endFunction

int function UpdateAddictionScore(Actor akTarget, float updateStep)
	Faction HarlotScoreFaction = CommonProperties.HarlotScoreFaction
	int HarlotScoreMaxRank = CommonProperties.HarlotScoreMaxRank
		
	if(akTarget.GetFactionRank(HarlotScoreFaction) < HarlotScoreMaxRank)
		int Step = Math.Floor((updateStep / 24.0) * CommonProperties.HarlotScorePerDay)
		COMMON_Utility.AddFactionRank(akTarget, HarlotScoreFaction, Step, HarlotScoreMaxRank)
	endIf
	
	int Score = akTarget.GetFactionRank(HarlotScoreFaction)
	if(CommonProperties.SettingDebugHarlot)
		Debug.Notification("[MoaH] Harlot addiction score update on " + akTarget.GetDisplayName() + ". Current value " + Score)
	endIf
	
	return Score
endFunction

function UpdateMorphs(Actor akTarget, float updateStep)
	Faction HarlotBodyMorphFaction = CommonProperties.HarlotBodyMorphFaction
	Faction HarlotBreastMorphFaction = CommonProperties.HarlotBreastMorphFaction
	int HarlotScoreMaxRank = CommonProperties.HarlotScoreMaxRank
	if(akTarget.GetFactionRank(HarlotBodyMorphFaction) <= HarlotScoreMaxRank)
		int Step = Math.Floor(updateStep * CommonProperties.HarlotScorePerDay / 24.0)
		COMMON_Utility.AddFactionRank( akTarget, HarlotBodyMorphFaction, Step, HarlotScoreMaxRank)
	endIf
	
	int Score = akTarget.GetFactionRank(HarlotBodyMorphFaction)
	COMMON_MorphUtility.MorphActor(akTarget, CommonProperties.SettingHarlotBodyMorphFile, (Score as float)/(HarlotScoreMaxRank as float))
	
	
	if(akTarget.GetFactionRank(HarlotBreastMorphFaction) <= HarlotScoreMaxRank)
		int Step = Math.Floor((updateStep / 24.0) * CommonProperties.HarlotScorePerDay)
		COMMON_Utility.AddFactionRank( akTarget, HarlotBreastMorphFaction, Step, HarlotScoreMaxRank)
	endIf


	Score = akTarget.GetFactionRank(HarlotBreastMorphFaction)
	COMMON_MorphUtility.MorphActor(akTarget, CommonProperties.SettingHarlotBreastMorphFile, (Score as float)/(HarlotScoreMaxRank as float))

	;if(CommonProperties.SettingDebugHarlot)
	;	Debug.Notification("[MoaH] Harlot morph score update on " + akTarget.GetDisplayName() + ". Current value " + Score)
	;endIf
	; Finally tell Racemenu to update morphs
	NiOverride.UpdateModelWeight(akTarget)
endFunction

function UpdateFactionRanks(Actor akTarget, int Score)
	MoaH_QuestIntroduction IntroductionQuest = CommonProperties.IntroductionQuest
	int iqCSI = IntroductionQuest.GetCurrentStageID()
	; Update keywords
	
	int rank = akTarget.GetFactionRank(CommonProperties.HarlotStagesFaction)
	
	if (rank < 3 && Score > 90) ; {HarlotScoreMaxRank*2/3}
		UpdateAbilities(akTarget,3)
	elseif(rank < 2 && Score > 40) ; {HarlotScoreMaxRank/2}
		UpdateAbilities(akTarget,2)
	else
		UpdateAbilities(akTarget,1)
	endIf
endFunction

function UpdateAbilities(Actor akTarget, int stage)
	akTarget.SetFactionRank(CommonProperties.HarlotStagesFaction, stage)
	if(lastUpdateStage == stage) 
		return
	endif
	
	if(!stage1ToStage2Passed && lastUpdateStage == 1 && stage == 2)
		stage1ToStage2Passed = true
		Debug.MessageBox("My hands have wondered on my breasts and I was fondling them. Its getting worse!")
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

function UpdateArousalBoundaries(int harlotSexAddictionStage)
	if(harlotSexAddictionStage == 3)
		CommonProperties.PlayerArousalBoundaryExcited = CommonProperties.DefaultArousalBoundaryExcited - 50
		CommonProperties.PlayerArousalBoundaryHorny = CommonProperties.DefaultArousalBoundaryHorny - 65
	elseIf(harlotSexAddictionStage == 2)
		CommonProperties.PlayerArousalBoundaryExcited = CommonProperties.DefaultArousalBoundaryExcited - 20
		CommonProperties.PlayerArousalBoundaryHorny = CommonProperties.DefaultArousalBoundaryHorny - 20
	elseIf(harlotSexAddictionStage == 1)
		CommonProperties.PlayerArousalBoundaryExcited = CommonProperties.DefaultArousalBoundaryExcited
		CommonProperties.PlayerArousalBoundaryHorny = CommonProperties.DefaultArousalBoundaryHorny
	endIf
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
	Debug.Trace("[MoaH] Harlot status ending. On " + target.GetDisplayName())
	UnregisterForUpdateGameTime()
	UnregisterForSleep()
	akTarget.SetFactionRank(CommonProperties.HarlotStagesFaction, 0)
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
	
	if(target.HasSpell(LongNails1))
		target.RemoveSpell(LongNails1)
	endif
	if(target.HasSpell(LongNails2))
		target.RemoveSpell(LongNails2)
	endif
	if(target.HasSpell(LongNails3))
		target.RemoveSpell(LongNails3)
	endif
	
	if(target.HasSpell(LightMinded1))
		target.RemoveSpell(LightMinded1)
	endif
	if(target.HasSpell(LightMinded2))
		target.RemoveSpell(LightMinded2)
	endif
	if(target.HasSpell(LightMinded3))
		target.RemoveSpell(LightMinded3)
	endif
	
	if(target.HasSpell(Pretty1))
		target.RemoveSpell(Pretty1)
	endif
	if(target.HasSpell(Pretty2))
		target.RemoveSpell(Pretty2)
	endif
	if(target.HasSpell(Pretty3))
		target.RemoveSpell(Pretty3)
	endif
	
	if(target.HasSpell(Fragile1))
		target.RemoveSpell(Fragile1)
	endif
	if(target.HasSpell(Fragile2))
		target.RemoveSpell(Fragile2)
	endif
	if(target.HasSpell(Fragile3))
		target.RemoveSpell(Fragile3)
	endif
	
	if(target.HasSpell(Cunning1))
		target.RemoveSpell(Cunning1)
	endif
	if(target.HasSpell(Cunning2))
		target.RemoveSpell(Cunning2)
	endif
	if(target.HasSpell(Cunning3))
		target.RemoveSpell(Cunning3)
	endif
endEvent