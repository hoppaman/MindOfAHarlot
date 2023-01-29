Scriptname SLAT_QuestThoughts extends Quest

import SLAT_GlobalUtility

SLAT_QuestCommonProperties Property CommonProperties Auto

SLAT_QuestThoughtsScanner Property Scanner Auto



; SLAT_ThoughtProviderBase
Form[] providers = NONE

event OnInit()
	UnregisterForUpdate()
	RegisterForUpdate(CommonProperties.SettingThoughtsInterval)
	UnregisterForAllModEvents()
	RegisterForModEvent(CommonProperties.RegisterThoughtProviderEventName, "RegisterThoughtProviderEvent")
	RegisterForModEvent(CommonProperties.UnregisterThoughtProviderEventName, "UnregisterThoughtProviderEvent")
endEvent
	
event RegisterThoughtProviderEvent(Form tp)
	RegisterThoughtProvider(tp as SLAT_ThoughtProviderBase)
endEvent

event UnregisterThoughtProviderEvent(Form tp)
	RemoveThoughtProvider(tp as SLAT_ThoughtProviderBase)
endEvent

function RegisterThoughtProvider(SLAT_ThoughtProviderBase thoughtProvider)
	providers = PapyrusUtil.PushForm(providers, thoughtProvider)
endFunction

function RemoveThoughtProvider(SLAT_ThoughtProviderBase thoughtProvider)
	PapyrusUtil.RemoveForm(providers, thoughtProvider)
endFunction

event OnUpdate()
	Actor player = Game.GetPlayer()
	bool pcLikesMales = COMMON_Utility.IsAIntoSex(player, 0)
	bool pcLikesFemales = COMMON_Utility.IsAIntoSex(player, 1)

	if(IsOn(CommonProperties.DebugThoughtsGlobal))
		Debug.Trace("[MoaH] Thoughts update")
	endIf
	
	int foundCount = scanner.Scan()
	Actor closeByCrush
	if(foundCount > 0)
		if(scanner.CloseByMale && pcLikesMales)
			closeByCrush = scanner.CloseByMale.GetActorRef()
		elseIf(scanner.CloseByFemale && pcLikesFemales)
			closeByCrush = scanner.CloseByFemale.GetActorRef()
		endIf
		
		; TODO: Rich & guard
	endIf
		
	string thought = GetRandomThought(closeByCrush)
	if(StringUtil.Find(thought,"<RandomVisibleNPCMale>") != -1)
		thought = COMMON_Utility.ReplaceString(thought,"<RandomVisibleNPCMale>", "Bob")
	endIf
	
	PresentThought(thought)
endEvent

Function PresentThought(string thought)
	Debug.Notification(thought)
endFunction

string function GetRandomThought(Actor closeByCrush)
	Actor player = Game.GetPlayer()
	int index = 0
	int tpCount = providers.Length
	string[] thoughts = Utility.CreateStringArray(tpCount, "NO_THOUGHT")
	while index < tpCount
		SLAT_ThoughtProviderBase thoughtProvider = providers[index] as SLAT_ThoughtProviderBase
		if(thoughtProvider.HasThought(closeByCrush))
			thoughts[index] = thoughtProvider.GetThought(closeByCrush)
		endIf
		index += 1
	endWhile
	thoughts = PapyrusUtil.RemoveString(thoughts, "NO_THOUGHT")
	return COMMON_Utility.GetRandomString(thoughts)
endFunction
