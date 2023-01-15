Scriptname SLAT_QuestThoughts extends Quest

SLAT_QuestCommonProperties Property CommonProperties Auto

; SLAT_ThoughtProviderBase
Form[] providers = NONE

event OnInit()
	
	RegisterForUpdate(CommonProperties.SettingThoughtsInterval)
endEvent
	
event OnReset()
	UnregisterForUpdate()
	RegisterForUpdate(CommonProperties.SettingThoughtsInterval)
endEvent

event OnLoadGame()
	UnregisterForUpdate()
	RegisterForUpdate(CommonProperties.SettingThoughtsInterval)
endEvent

function RegisterThoughtProvider(SLAT_ThoughtProviderBase thoughtProvider)
	providers = PapyrusUtil.PushForm(providers, thoughtProvider)
endFunction

function RemoveThoughtProvider(SLAT_ThoughtProviderBase thoughtProvider)
	PapyrusUtil.RemoveForm(providers, thoughtProvider)
endFunction

event OnUpdate()
	Debug.Trace("[MoaH] Thoughts update")
		
	Actor[] closeByActors = COMMON_Utility.FindAdultActorsNear(Game.GetPlayer(), 6000, 0)
	
	bool done = false
	bool acceptRandomVisibleNPCMale = closeByActors.Length > 0
	string thought
	While !done
		thought = GetRandomThought()
		if(StringUtil.Find(thought,"<RandomVisibleNPCMale>") != -1)
			if(acceptRandomVisibleNPCMale)
				thought=COMMON_Utility.ReplaceString(thought,"<RandomVisibleNPCMale>", "Bob")
				done = true
			endIf
		else
			done = true
		endIf
	endWhile
	Debug.Notification(thought)
endEvent

string function GetRandomThought()
	Actor player = Game.GetPlayer()

	; Memories
	; Quest stage/completion related things
	
	; Prioritize
	; Sex Partner Thoughts
	;SexLab.LastSexPartner
	;SexLab.MostUsedPlayerSexPartners
	
;	float chance = Utility.RandomFloat(0.0, 100.0)
;	If(HasRecentSexPartner() && chance < 10)
;		return "<daydream here>"
;	elseIf(HasRecentMemories() && chance < 50)
;		return "<memory here>"
;	else
;		return GetCommonThoughtsForFemale(addictionStage, arousalStage)
;	endIf
	int index = 0
	int tpCount = providers.Length
	string[] thoughts = Utility.CreateStringArray(tpCount, "NO_THOUGHT")
	while index < tpCount
		SLAT_ThoughtProviderBase thoughtProvider = providers[index] as SLAT_ThoughtProviderBase
		if(thoughtProvider.HasThought())
			thoughts[index] = thoughtProvider.GetThought()
		endIf
	endWhile
	thoughts = PapyrusUtil.RemoveString(thoughts, "NO_THOUGHT")
	return COMMON_Utility.GetRandomString(thoughts)
endFunction
