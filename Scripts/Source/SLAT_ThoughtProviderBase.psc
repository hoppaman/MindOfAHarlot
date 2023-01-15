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

function RegisterThoughtProvider()
	; Really hacky thing, to ensure that event doesnt fire before the tracker is up lets wait
	Utility.Wait(60.0)
	Int EventHandle = ModEvent.Create(CommonProperties.RegisterThoughtProviderEventName)
	ModEvent.PushForm(EventHandle, self) ; Timeout
	ModEvent.Send(EventHandle)
endFunction