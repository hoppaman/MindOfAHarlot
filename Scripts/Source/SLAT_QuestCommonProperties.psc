Scriptname SLAT_QuestCommonProperties extends Quest  

; Integrations
SexLabFramework Property SexLab Auto
slaFrameworkScr Property SLA Auto

SLAT_QuestThoughts Property ThoughtsQuest Auto

Spell Property MasturbatePower Auto
Spell Property TeasePower Auto

GlobalVariable Property DebugCommentsGlobal Auto

; Thought settings
float Property SettingThoughtsInterval = 60.0 Auto Hidden

Keyword Property IsTeasingKeyword Auto


Spell Property MarkSpectatorAbility Auto

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