scriptname MoaH_QuestHarlotSLATTPMale extends SLAT_ThoughtProviderBase

bool function HasThought(Actor closeByCrush)
	return false
endFunction

; Relating to quest or sex partner..
int function GetProviderPriority(Actor closeByCrush)
	return 30
endFunction

string function GetThought(Actor closeByCrush)
	return None
endFunction

