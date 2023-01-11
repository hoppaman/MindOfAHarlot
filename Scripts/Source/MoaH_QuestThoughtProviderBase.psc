scriptname MoaH_QuestThoughtProviderBase extends MoaH_QuestBase Hidden

MoaH_QuestCommonProperties Property CommonProperties Auto
MoaH_QuestUtility Property MUtility Auto

bool function HasThoughts()
	return false
endFunction

; Relating to quest or sex partner..
bool function HasPriorityThought()
	return false
endFunction

string function GetThought()
	return None
endFunction

