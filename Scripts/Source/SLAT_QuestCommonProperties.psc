Scriptname SLAT_QuestCommonProperties extends Quest  

SLAT_QuestThoughts Property ThoughtsQuest Auto

Spell Property MasturbatePower Auto
Spell Property TeasePower Auto

; Debug toggles
GlobalVariable Property DebugCommentsGlobal Auto
GlobalVariable Property DebugThoughtsGlobal Auto
GlobalVariable Property DebugSpectatorsGlobal Auto

; Thought settings
float Property SettingThoughtsInterval = 60.0 Auto Hidden
float Property PlayerRuntimeVariablesUpdateInterval = 1.5 Auto Hidden

; Nail polish
Keyword Property IsWearingNailPolish auto

Keyword Property IsTeasingKeyword Auto
Faction Property IsSexistFaction Auto
Faction Property IsHedonistFaction Auto

Spell Property SpectatorCooldownAbility Auto

Spell Property SpectatorSlapCooldownAbility Auto
Keyword Property SpectatorSlapCooldownKeyword Auto
Spell Property SpectatorCommentCooldownAbility Auto
Keyword Property SpectatorCommentCooldownKeyword Auto
Spell Property SpectatorMasrtubateCooldownAbility Auto
Keyword Property SpectatorMasturbateCooldownKeyword Auto
Spell Property SpectatorRapeCooldownAbility Auto
Keyword Property SpectatorRapeCooldownKeyword Auto

Faction Property SexAddictionStagesFaction Auto
Spell Property SexAddictionHighArousalIMAD Auto
int Property SAHA_ArousalToApplyIMAD = 70 Auto Hidden

; Morphs
Faction Property MorphScoreBigBreast Auto
Faction Property MorphScoreHourglassBody Auto
Faction Property MorphScoreRoundAss Auto

;;;;;
;; Runtime states
;; Updated by several places -- (optimization)
;;;;;

bool Property PlayerIsNaked Auto Hidden
bool Property PlayerIsTeasing Auto Hidden
bool Property PlayerHasCumOn Auto Hidden
bool Property PlayerIsHavingSex Auto Hidden

;;;;;
;; Mod Events
;;;;;

string Property FlatterEventName = "SLAT_Flattered" autoReadonly hidden

string Property RegisterThoughtProviderEventName = "SLAT_RegisterThoughtProvider" autoReadonly hidden
string Property UnregisterThoughtProviderEventName = "SLAT_UnregisterThoughtProvider" autoReadonly hidden

;TODO: "Is teasing" is needed?
;Faction property IsAnimatingFaction Auto