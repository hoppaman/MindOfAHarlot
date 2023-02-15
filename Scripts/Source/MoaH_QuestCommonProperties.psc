Scriptname MoaH_QuestCommonProperties extends MoaH_QuestBase

; Globals - dialogue...
GlobalVariable Property PlayerHarlotAddictionProgressFloat Auto
GlobalVariable Property PlayerHarlotMorphsProgressFloat Auto

; Common quests
MoaH_QuestIntroduction Property IntroductionQuest Auto
MoaH_QuestSuccubusIntroduction Property SuccubusIntroductionQuest Auto
MoaH_QuestSanguinesFavor Property SanguinesFavorQuest Auto
MoaH_QuestModEventTracker Property ModEventTrackerQuest Auto

; Integrations
SexLabFramework Property SexLab Auto
slaFrameworkScr Property SLA Auto
SOS_SetupQuest_Script Property SOSSetupQuest Auto
SLSF_CompatibilityScript Property SLSF Auto

Keyword Property ActorTypeNPCKeyword auto

; Factions
Faction property HarlotFaction Auto ; Intended to be harlot faction but probably no use. Name is still reserved
Faction property HarlotScoreFaction Auto ; Score
Faction Property HarlotStagesFaction auto ; Which stage this is for easy dialogue
Faction property HarlotBreastMorphFaction Auto
Faction Property HarlotBodyMorphFaction Auto
Faction property SanguineStandingFaction Auto
Faction property SuccubusFaction Auto
Faction property SuccubusSatiationFaction Auto

; Active properties

; Note tara maybe either spirit (wisp) or possessed actor
ReferenceAlias Property TaraRef Auto

; MoaH's copy of sanguine
ReferenceAlias Property MoaHSanguineRef Auto

Spell Property TurnHarlotAbility Auto

; Harlot buffs and debuffs

; Long nails
Spell Property HarlotLongNailsStage1Ability Auto
Spell Property HarlotLongNailsStage2Ability Auto
Spell Property HarlotLongNailsStage3Ability Auto

; Light minded
Spell Property HarlotLightMindedStage1Ability Auto
Spell Property HarlotLightMindedStage2Ability Auto
Spell Property HarlotLightMindedStage3Ability Auto

; Pretty
Spell Property HarlotPrettyStage1Ability Auto
Spell Property HarlotPrettyStage2Ability Auto
Spell Property HarlotPrettyStage3Ability Auto

; Fragile
Spell Property HarlotFragileStage1Ability Auto
Spell Property HarlotFragileStage2Ability Auto
Spell Property HarlotFragileStage3Ability Auto

; Cunning
Spell Property HarlotCunningStage1Ability Auto
Spell Property HarlotCunningStage2Ability Auto
Spell Property HarlotCunningStage3Ability Auto

; Player
float Property PlayerArousalBoundaryExcited = 60.0 Auto Hidden
float Property PlayerArousalBoundaryHorny = 80.0 Auto Hidden

; At stage1
float Property DefaultArousalBoundaryExcited = 60.0 autoReadonly Hidden; Feeling ok or "normal" until over this
float Property DefaultArousalBoundaryHorny = 80.0 autoReadonly Hidden; a between b you feel horny, 

; Harlot
int Property HarlotScoreMaxRank = 127 autoReadonly Hidden
int Property HarlotScorePerDay = 20 autoReadonly Hidden
int Property HarlotScorePerAnal = 5 autoReadonly Hidden
int Property HarlotScorePerSwallow = 5 autoReadonly Hidden
int Property HarlotScorePerNormalSex = 2 autoReadonly Hidden

Float Property HarlotScoreUpdateIntervalGameTime = 1.0 autoReadonly Hidden; every half hour gt
; Curse will fulfill in a 2 days

;;;;;
;; Config
;;;;;

; Debug settings
bool Property SettingDebugHarlot = true Auto Hidden
bool Property SettingDebugSuccubus = true Auto Hidden
bool Property SettingDebugIntroduction = true Auto Hidden
bool Property SettingDebugSanguine = true Auto Hidden

