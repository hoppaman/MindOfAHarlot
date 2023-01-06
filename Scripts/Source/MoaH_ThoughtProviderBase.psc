scriptname MoaH_ThoughtProviderBase extends MoaH_QuestBase Hidden

MoaH_CommonProperties Property CommonProperties Auto
MoaH_Utility Property MUtility Auto

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

