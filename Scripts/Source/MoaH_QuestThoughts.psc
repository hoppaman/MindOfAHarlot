Scriptname MoaH_QuestThoughts extends MoaH_QuestBase

MoaH_QuestCommonProperties Property CommonProperties Auto
MoaH_QuestUtility Property MUtility Auto

MoaH_QuestThoughtProviderFemale Property FemaleThoughtProvider Auto
{Mostly arousal related}
MoaH_QuestThoughtProviderFemaleMemory Property FemaleMemoryThoughtProvider Auto
{quest and other thoughts}
MoaH_QuestThoughtProviderMale Property MaleThoughtProvider Auto
{Not supported yet}
MoaH_QuestThoughtProviderMaleMemory Property MaleMemoryThoughtProvider Auto
{Not supported yet}

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

event OnUpdate()
	Debug.Trace("[MoaH] Thoughts update")
	; Updates arousal limits to correct addiction stage
	UpdateArousalBoundaries(MUtility.GetAddictionStage(Game.GetPlayer()))
	
	Actor[] closeByActors = MUtility.FindAdultActorsNear(Game.GetPlayer(), 6000, 0)
	
	bool done = false
	bool acceptRandomVisibleNPCMale = closeByActors.Length > 0
	string thought
	While !done
		thought = GetRandomThought()
		if(StringUtil.Find(thought,"<RandomVisibleNPCMale>") != -1)
			if(acceptRandomVisibleNPCMale)
				thought=MUtility.ReplaceString(thought,"<RandomVisibleNPCMale>", "Bob")
				done = true
			endIf
		else
			done = true
		endIf
	endWhile
	Debug.Notification(thought)
endEvent

function UpdateArousalBoundaries(int harlotSexAddictionStage)
	if(harlotSexAddictionStage == 3)
		CommonProperties.PlayerArousalBoundaryExcited = CommonProperties.DefaultArousalBoundaryExcited - 50
		CommonProperties.PlayerArousalBoundaryHorny = CommonProperties.DefaultArousalBoundaryHorny - 65
	elseIf(harlotSexAddictionStage == 2)
		CommonProperties.PlayerArousalBoundaryExcited = CommonProperties.DefaultArousalBoundaryExcited - 20
		CommonProperties.PlayerArousalBoundaryHorny = CommonProperties.DefaultArousalBoundaryHorny - 20
	elseIf(harlotSexAddictionStage == 1)
		CommonProperties.PlayerArousalBoundaryExcited = CommonProperties.DefaultArousalBoundaryExcited
		CommonProperties.PlayerArousalBoundaryHorny = CommonProperties.DefaultArousalBoundaryHorny
	endIf
endFunction

string function GetRandomThought()
	Actor player = Game.GetPlayer()
	int addictionStage = MUtility.GetAddictionStage(player)
	int arousalStage = MUtility.GetArousalStage(player)
	int sex = player.GetActorBase().GetSex()

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

	if(sex == 0)
		float chance = Utility.RandomFloat(0.0, 100.0)
		if(MaleMemoryThoughtProvider.HasThoughts() && chance > 75)
			return MaleMemoryThoughtProvider.GetThought()
		elseif(MaleThoughtProvider.HasThoughts())
			return MaleThoughtProvider.GetThought()
		endIf
	elseif(sex == 1)
		float chance = Utility.RandomFloat(0.0, 100.0)
		if(FemaleMemoryThoughtProvider.HasThoughts() && chance > 75)
			return FemaleMemoryThoughtProvider.GetThought()
		elseif(FemaleThoughtProvider.HasThoughts())
			return FemaleThoughtProvider.GetThought()
		endIf
	else
		Debug.Trace("[MoaH] Actor with no sex")
	endIf
	
endFunction
