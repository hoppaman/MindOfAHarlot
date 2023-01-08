Scriptname MoaH_CommonProperties extends MoaH_QuestBase

; Actors
Actor Property PlayerRef Auto

; Common quests
MoaH_IntroductionQuest Property IntroductionQuest Auto
MoaH_FlirtDialogueQuest Property FlirtDialogueQuest Auto
MoaH_SuccubusIntroductionQuest Property SuccubusIntroductionQuest Auto
MoaH_ThoughtsQuest Property ThoughtsQuest Auto
MoaH_ModEventTrackerQuest Property ModEventTrackerQuest Auto

; Integrations
SexLabFramework Property SexLab Auto
SOS_SetupQuest_Script Property SOSSetupQuest Auto
SLSF_CompatibilityScript Property SLSF Auto
slaFrameworkScr Property SLA Auto

; Keywords
Keyword Property HarlotSexAddictionStage1Keyword  Auto
{Feels the effects}
Keyword Property HarlotSexAddictionStage2Keyword  Auto
{Effects get much stronger}
Keyword Property HarlotSexAddictionStage3Keyword  Auto
{Constantly aroused and horny}

Keyword Property ActorTypeNPCKeyword auto


; Perks/Spell/MGEF
Spell Property MasturbateAbility Auto
Spell Property FondleAbility Auto

; Factions
Faction property HarlotFaction Auto
Faction property HarlotScoreFaction Auto
Faction property SanguineStandingFaction Auto
Faction property SuccubusFaction Auto
Faction property SuccubusSatiationFaction Auto
Faction property IsAnimatingFaction Auto


; Active properties

; Note tara maybe either spirit (wisp) or possessed actor
Actor Property Tara = None Auto
ActorBase Property TarasSpirit Auto


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
int Property HarlotScorePerDay = 24 autoReadonly Hidden ; 255.0/7.0

Float Property HarlotScoreUpdateIntervalGameTime = 1.0 autoReadonly Hidden; every half hour gt
; Curse will fulfill in a 2 days

;;;;;
;; Mod Events
;;;;;

string Property AttentionLookAtEventName = "MoaH_AttentionLookAt" autoReadonly hidden

;;;;;
;; Config
;;;;;

; Debug settings
bool Property SettingDebugHarlot = true Auto Hidden
bool Property SettingDebugSuccubus = true Auto Hidden
bool Property SettingDebugIntroduction = true Auto Hidden
bool Property SettingDebugSanguine = true Auto Hidden

; Thought settings
float Property SettingThoughtsInterval = 60.0 Auto Hidden

string Property SettingHarlotMorphFile = "MoaH_HarlotMorphs.json" Auto Hidden