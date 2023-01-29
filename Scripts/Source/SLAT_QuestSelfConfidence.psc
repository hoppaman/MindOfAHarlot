Scriptname SLAT_QuestSelfConfidence extends Quest  

SLAT_QuestCommonProperties Property CommonProperties Auto

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
Actor player
event OnInit()
	player = Game.GetPlayer()
	SelfConfidenceScore = AcceptableSelfConfidenceScore
	RegisterForModEvent("SLAT_Flattered", "OnSLATFlattered")
	RegisterForModEvent("SLAT_Watched", "OnSLATWatched")
	RegisterForUpdateGameTime(1.0)
	lastUpdateTime = Utility.GetCurrentGameTime()
	Update()
endEvent

event OnSLATFlattered(Actor akSpeaker)
	Debug.Notification("You enjoy to be watched.")
	SelfConfidenceScore += SelfConfidenceScoreTinyBoost
endEvent

event OnSLATWatcheded(Actor akWatcher)
	Debug.Notification("You enjoy to be watched.")
	SelfConfidenceScore += SelfConfidenceScoreTinyBoost
endEvent

event OnUpdateGameTime()
	Update()
endEvent

function Update()
	; TODO: exhibitionist

	; As player can wait or sleep we cannot trust that Update hits always. Count the real time passed.
	int rank = player.GetFactionRank(CommonProperties.SexAddictionStagesFaction)
	float step = PapyrusUtil.ClampFloat((Utility.GetCurrentGameTime() - lastUpdateTime) * 24, 1.0, 48)
	lastUpdateTime = Utility.GetCurrentGameTime()
	
	SelfConfidenceScore += SelfConfidenceScoreChangePerDay/24.0 * step
	if(rank != 3)
		SelfConfidenceScore += SelfLooksDoubtPerDay/24.0 * step
	endIf
	SelfConfidenceScore = PapyrusUtil.ClampFloat(SelfConfidenceScore, 0, SelfConfidenceScore)
endFunction