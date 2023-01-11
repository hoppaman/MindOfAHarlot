Scriptname MoaH_QuestSelfConfidence extends Quest  

MoaH_QuestCommonProperties Property CommonProperties Auto
MoaH_QuestUtility Property MUtility Auto

float Property SelfConfidenceScoreMax = 100.0 autoReadonly Hidden
float Property SelfConfidenceScore Auto Hidden
float Property AcceptableSelfConfidenceScore = 50.0 Auto Hidden

; Gains
float Property SelfConfidenceScoreTinyBoost = 2.0 autoReadonly Hidden
float Property SelfConfidenceScoreSmallBoost = 5.0 autoReadonly Hidden
float Property SelfConfidenceScoreModerateBoost = 7.5 autoReadonly Hidden
float Property SelfConfidenceScoreGreaterBoost = 10.0 autoReadonly Hidden
float Property SelfConfidenceScoreHugeBoost = 15.0 autoReadonly Hidden

; Loses
float Property SelfConfidenceScoreChangePerDay = -10.0 autoReadonly Hidden
float Property SelfLooksDoubtPerDay = -5.0 autoReadonly Hidden

float lastUpdateTime = 0.0

event OnInit()
	SelfConfidenceScore = AcceptableSelfConfidenceScore
	RegisterForModEvent(CommonProperties.AttentionPlayerLookAtEventName, "Att_PlayerIsLookedAt")
	RegisterForModEvent("_STA_RandomRunUpAndSpankComplete", "STA_RandomRunUpAndSpankCompleted")
	RegisterForUpdateGameTime(1.0)
	lastUpdateTime = Utility.GetCurrentGameTime()
	Update()
endEvent

event Att_PlayerIsLookedAt(Actor akViewer, float distance)
	Debug.Notification("You enjoy to be watched.")
	SelfConfidenceScore += SelfConfidenceScoreTinyBoost
endEvent

event STA_RandomRunUpAndSpankCompleted()
	Debug.Notification("You enjoy the attention.")
	SelfConfidenceScore += SelfConfidenceScoreModerateBoost
endEvent

event OnUpdateGameTime()
	Update()
endEvent

function Update()
	; As player can wait or sleep we cannot trust that Update hits always. Count the real time passed.
	float step = PapyrusUtil.ClampFloat((Utility.GetCurrentGameTime() - lastUpdateTime) * 24, 1.0, 48)
	lastUpdateTime = Utility.GetCurrentGameTime()
	
	SelfConfidenceScore += SelfConfidenceScoreChangePerDay/24.0 * step
	if(!Game.GetPlayer().HasKeyword(CommonProperties.HarlotSexAddictionStage3Keyword))
		SelfConfidenceScore += SelfLooksDoubtPerDay/24.0 * step
	endIf
	SelfConfidenceScore = PapyrusUtil.ClampFloat(SelfConfidenceScore, 0, SelfConfidenceScore)
endFunction