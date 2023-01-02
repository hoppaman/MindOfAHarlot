Scriptname MoaH_HarlotMGEF extends activemagiceffect  

MoaH_CommonProperties property CommonProperties auto

float Progress = 0.0

event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Harlot status starting.")
	RegisterForUpdateGameTime(CommonProperties.HarlotUpdateIntervalGameTime)
endEvent

event OnUpdateGameTime()
	Actor target = GetTargetActor()
	MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
	Keyword DesireStage1 = CommonProperties.DesireStage1
	Keyword DesireStage2 = CommonProperties.DesireStage2
	Keyword DesireStage3 = CommonProperties.DesireStage3
	if(CommonProperties.DebugHarlot)
		Debug.Notification("[MoaH] Harlot curse update. Current value " + Progress)
	endIf
	
	Progress = Progress + CommonProperties.DesireProgressStep
	if(Progress > 1.0)
		Progress = 1.0
		; TODO: Chance to force fondle
	endIf
	
	bool isPlayer = target == CommonProperties.PlayerRef
	
	if(isPlayer)
		CommonProperties.PlayerHarlotProgress = Progress
	endIf
	
	int iqCSI = IntroductionQuest.GetCurrentStageID()
	
	if(!target.HasKeyword(DesireStage2) && Progress > 0.5)
		PO3_SKSEFunctions.AddKeywordToForm(target, DesireStage2)
		PO3_SKSEFunctions.RemoveKeywordOnForm(target, DesireStage3)
		
		if(isPlayer && !IntroductionQuest.IsCompleted() && iqCSI >= 120 && iqCSI < 160)
			Debug.MessageBox("My hands have wondered on my breasts and I was fondling them. Its getting worse!")
		endIf	
	elseif (!target.HasKeyword(DesireStage2) && Progress > 0.75)
		PO3_SKSEFunctions.AddKeywordToForm(target, DesireStage3)
		if(isPlayer &&!IntroductionQuest.IsCompleted() && iqCSI >= 120 && iqCSI < 160)
			Debug.MessageBox("My hands wonder on my body and its tingling. My nipples are visibly stiff and its difficult to hold the excitement. Its so difficult to think now!")
		endIf	
	elseif (!target.HasKeyword(DesireStage1) || target.HasKeyword(DesireStage3) || target.HasKeyword(DesireStage2))
		if(CommonProperties.DebugHarlot)
			Debug.Notification("[MoaH] Cleared desire")
		endIf
		PO3_SKSEFunctions.AddKeywordToForm(target, DesireStage1)
		PO3_SKSEFunctions.RemoveKeywordOnForm(target, DesireStage2)
		PO3_SKSEFunctions.RemoveKeywordOnForm(target, DesireStage3)
	endIf
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	Debug.Trace("[MoaH] Harlot status ending. On " + akTarget.GetDisplayName())
	UnregisterForUpdateGameTime()
endEvent