Scriptname MoaH_CommonProperties extends Quest

; Actors
Actor Property PlayerRef Auto

; Common quests
MoaH_IntroductionQuest Property IntroductionQuest Auto
MoaH_FlirtDialogueQuest Property FlirtDialogueQuest Auto
SexLabFramework Property SexLab Auto

; Keywords
Keyword Property DesireStage1  Auto 
Keyword Property DesireStage2  Auto 
Keyword Property DesireStage3  Auto  

; Perks/Spell/MGEF
MoaH_HarlotPerk Property HarlotPerk  Auto  
Spell Property MasturbateAbility Auto
Spell Property FondleAbility Auto

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
Float Property PlayerHarlotProgress = 0.0 Auto  
Float Property HarlotUpdateIntervalGameTime = 0.5 Auto ; every half hour gt
; Curse will fulfill in a 2 days
Float Property DesireProgressStep = 0.0208 Auto