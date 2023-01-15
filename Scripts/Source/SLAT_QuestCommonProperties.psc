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

;;;;;
;; Mod Events
;;;;;

string Property FlatterEventName = "SLAT_Flattered" autoReadonly hidden

;TODO: "Is teasing" is needed?
;Faction property IsAnimatingFaction Auto