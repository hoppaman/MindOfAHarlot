scriptname MoaH_QuestUtility extends MoaH_QuestBase

MoaH_QuestCommonProperties Property CommonProperties Auto

int function GetArousalStage(Actor akActor)
	int arousal = CommonProperties.SLA.GetActorArousal(akActor)
	if(arousal >= CommonProperties.PlayerArousalBoundaryHorny)
		return 3
	elseIf(arousal >= CommonProperties.PlayerArousalBoundaryExcited)
		return 2
	else
		return 1
	endIf
endFunction

function AddHarlotScore(Actor akActor, int amount)
	Faction HarlotScoreFaction = CommonProperties.HarlotScoreFaction
	int HarlotScoreMaxRank = CommonProperties.HarlotScoreMaxRank
	COMMON_Utility.AddFactionRank(akActor, HarlotScoreFaction, amount, HarlotScoreMaxRank)
endFunction

function ReduceHarlotScore(Actor akActor, int amount)
	Faction HarlotScoreFaction = CommonProperties.HarlotScoreFaction
	COMMON_Utility.ReduceFactionRank(akActor, HarlotScoreFaction, amount)
endFunction