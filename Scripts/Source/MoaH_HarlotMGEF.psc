Scriptname MoaH_HarlotMGEF extends activemagiceffect  

MoaH_ConfigMenuQuest Property ConfigMenuQuest Auto
Quest Property IntroductionQuest Auto
Actor Property PlayerRef Auto

Perk Property HarlotPerk Auto

Keyword Property DesireStage1 Auto
Keyword Property DesireStage2 Auto
Keyword Property DesireStage3 Auto

Float Property Progress = 0.0 Auto  
Float Property UpdateInterval = 0.5 Auto ; every half hour gt

; Curse will fulfill in a 2 days
Float curseStep = 0.0208

event OnEffectStart(Actor akTarget, Actor akCaster)
	if(ConfigMenuQuest.DebugHarlot)
		Debug.Trace("Harlot status starting.")
	endIf
	RegisterForUpdateGameTime(UpdateInterval)
endEvent

event OnUpdateGameTime()
	Actor target = GetTargetActor()
	if(ConfigMenuQuest.DebugHarlot)
		Debug.Notification("Debug :: Harlot curse update")
	endIf
	Progress = Progress + curseStep
	if(Progress > 1.0)
		Progress = 1.0
		; TODO: Chance to force fondle
	endIf
	
	if(!target.HasKeyword(DesireStage2) && Progress > 0.5)
		PO3_SKSEFunctions.AddKeywordToForm(target, DesireStage2)
		PO3_SKSEFunctions.RemoveKeywordOnForm(target, DesireStage3)
		
		if(!IntroductionQuest.IsCompleted() && IntroductionQuest.GetCurrentStageID() >= 120 && IntroductionQuest.GetCurrentStageID() < 160)
			Debug.MessageBox("My hands have wondered on my breasts and I was fondling them. Its getting worse!")
		endIf	
	elseif (!target.HasKeyword(DesireStage2) && Progress > 0.75)
		PO3_SKSEFunctions.AddKeywordToForm(target, DesireStage3)
		if(!IntroductionQuest.IsCompleted() && IntroductionQuest.GetCurrentStageID() >= 120 && IntroductionQuest.GetCurrentStageID() < 160)
			Debug.MessageBox("My hands wonder on my body and its tingling. My nipples are visibly stiff and its difficult to hold the excitement. Its so difficult to think now!")
		endIf	
	elseif (!target.HasKeyword(DesireStage1) || target.HasKeyword(DesireStage3) || target.HasKeyword(DesireStage2))
		if(ConfigMenuQuest.DebugHarlot)
			Debug.Notification("Debug :: Cleared desire")
		endIf
		PO3_SKSEFunctions.AddKeywordToForm(target, DesireStage1)
		PO3_SKSEFunctions.RemoveKeywordOnForm(target, DesireStage2)
		PO3_SKSEFunctions.RemoveKeywordOnForm(target, DesireStage3)
	endIf
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(ConfigMenuQuest.DebugHarlot)
		Debug.Trace("Harlot status ending. On " + akTarget.GetDisplayName())
	endIf
	UnregisterForUpdateGameTime()
endEvent