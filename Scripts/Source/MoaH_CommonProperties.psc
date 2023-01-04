Scriptname MoaH_CommonProperties extends Quest

; Actors
Actor Property PlayerRef Auto

; Common quests
MoaH_IntroductionQuest Property IntroductionQuest Auto
MoaH_FlirtDialogueQuest Property FlirtDialogueQuest Auto
MoaH_SuccubusIntroductionQuest Property SuccubusIntroductionQuest Auto

; Integrations
SexLabFramework Property SexLab Auto
SOS_SetupQuest_Script Property SOSSetupQuest Auto
SLSF_CompatibilityScript Property SLSF Auto

; Keywords
Keyword Property DesireStage1  Auto
{Feels the effects}
Keyword Property DesireStage2  Auto
{Effects get much stronger}
Keyword Property DesireStage3  Auto
{Constantly aroused and horny}

; Perks/Spell/MGEF
MoaH_HarlotPerk Property HarlotPerk  Auto
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

; Debug flags
bool Property DebugHarlot = true Auto
bool Property DebugSuccubus = true Auto
bool Property DebugIntroduction = true Auto
bool Property DebugSanguine = true Auto

; Harlot
int Property HarlotScoreMaxRank = 255 Auto
int Property HarlotScorePerDay = 36 Auto ; 255.0/7.0

Float Property HarlotScoreUpdateIntervalGameTime = 0.5 Auto ; every half hour gt
; Curse will fulfill in a 2 days
int Property ScoreProgressStepPerInterval = 18 Auto ; (255/7)/(1/0.5)

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