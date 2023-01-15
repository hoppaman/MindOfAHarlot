scriptname SLAT_ThoughtProviderBase extends Quest Hidden

SLAT_QuestCommonProperties Property CommonProperties Auto

bool function HasThought()
	return false
endFunction

; OnLoadGame

; Relating to quest or sex partner..
bool function HasPriorityThought()
	return false
endFunction

string function GetThought()
	return None
endFunction

