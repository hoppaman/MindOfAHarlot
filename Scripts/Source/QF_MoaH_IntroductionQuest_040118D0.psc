;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF_MoaH_IntroductionQuest_040118D0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE MoaH_IntroductionQuest
Quest __temp = self as Quest
MoaH_IntroductionQuest kmyQuest = __temp as MoaH_IntroductionQuest
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(40)
SetObjectiveDisplayed(45)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE MoaH_IntroductionQuest
Quest __temp = self as Quest
MoaH_IntroductionQuest kmyQuest = __temp as MoaH_IntroductionQuest
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE MoaH_IntroductionQuest
Quest __temp = self as Quest
MoaH_IntroductionQuest kmyQuest = __temp as MoaH_IntroductionQuest
;END AUTOCAST
;BEGIN CODE
setObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE MoaH_IntroductionQuest
Quest __temp = self as Quest
MoaH_IntroductionQuest kmyQuest = __temp as MoaH_IntroductionQuest
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
