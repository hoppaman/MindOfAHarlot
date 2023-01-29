scriptname SLAT_ThoughtProviderBase extends Quest Hidden

SLAT_QuestCommonProperties Property CommonProperties Auto

bool function HasThought(Actor closeByCrush)
	return false
endFunction

; OnLoadGame
int function GetProviderPriority(Actor closeByCrush)
	return 30
endFunction

string function GetThought(Actor closeByCrush)
	return None
endFunction

function RegisterThoughtProvider()
	; Really hacky thing, to ensure that event doesnt fire before the tracker is up lets wait
	Utility.Wait(60.0)
	Int EventHandle = ModEvent.Create(CommonProperties.RegisterThoughtProviderEventName)
	ModEvent.PushForm(EventHandle, self) ; Timeout
	ModEvent.Send(EventHandle)
endFunction