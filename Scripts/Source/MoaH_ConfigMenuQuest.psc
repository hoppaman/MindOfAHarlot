Scriptname MoaH_ConfigMenuQuest extends SKI_ConfigBase

; Script version ....
;
; History
;

; Localization in Data/Interface/Translations/MoaH_<lang>.txt

Actor Property PlayerRef Auto
MoaH_FlirtDialogueQuest Property FlirtDialogueQuest Auto
MoaH_IntroductionQuest Property IntroductionQuest Auto
MoaH_HarlotPerk Property HarlotPerk Auto

bool Property DebugHarlot = true Auto
bool Property DebugSuccubus = true Auto
bool Property DebugIntroduction = true Auto
bool Property DebugSanguine = true Auto

string morphFile = "MoaH_HarlotMorphs.json"

int function GetVersion()
	return 1
endFunction

event OnConfigRegister()
	Debug.Trace("Mind of a Harlot SKY UI registered")
endEvent

event OnConfigInit()
	; Version 1 pages
	Pages = new string[5]
	Pages[0] = "$PageGeneral"
	Pages[1] = "$PageHarlot"
	Pages[2] = "$PageSanguine"
	Pages[3] = "$PageSuccubus"
	Pages[4] = "$PageDebug"
endEvent

event OnConfigOpen()
endEvent

event OnConfigClose()
endEvent

event OnVersionUpdate(int a_version)
	if(a_version > CurrentVersion)
		Debug.Trace("MoaH version update")
	endIf
endEvent

event OnPageReset (string a_page)
	if (a_page == "")
		LoadCustomContent("MoaH/res/mcm_logo.dds", 258, 95)
		return
	else
		UnloadCustomContent()
	endIf
	
	if(a_page == "$PageGeneral")
		AddHeaderOption("Dialogue")
		AddToggleOptionST("FlirtToggle","$ToggleFlirt", FlirtDialogueQuest.IsRunning())
	elseIf(a_page == "$PageHarlot")
		;AddHeaderOption("Desire")
		AddHeaderOption("$HeaderBodyMorphs")
		AddTextOptionST("SaveBodyMorphs","Current body morph values", "Save")
		;AddHeaderOption("$HeaderDebug")
	elseIf(a_page == "$PageSanguine")
		AddHeaderOption("$HeaderStanding")
		AddHeaderOption("$HeaderQuests")
		;AddHeaderOption("$HeaderDebug")
	elseIf(a_page == "$PageSuccubus")
		;AddHeaderOption("Skills")
		;AddHeaderOption("Curse")
		;AddHeaderOption("$HeaderDebug")
	elseIf(a_page == "$PageDebug")
		AddHeaderOption("Introduction")
		AddToggleOptionST("IntroductionQuestDebugToggle","$ToggleIntroductionQuestDebug",DebugIntroduction)
		AddToggleOptionST("StartIntroductionToggle", "Introduction started",IntroductionQuest.GetCurrentStageID() > 0)
		AddHeaderOption("Harlot")
		AddToggleOptionST("HarlotDebugToggle","$ToggleHarlotDebug",DebugHarlot)
		AddToggleOptionST("HarlotToggle", "You are a harlot", PlayerRef.HasPerk(HarlotPerk))
		AddHeaderOption("Sanguine")
		AddToggleOptionST("SanguineDebugToggle","$ToggleSanguineDebug",DebugSanguine)
		AddHeaderOption("Introduction")
		AddToggleOptionST("SuccubusDebugToggle","$ToggleSuccubusDebug",DebugSuccubus)
	else
		; unknown
	endIf
	
endEvent

state FlirtToggle
	event OnDefaultST()
		bool IsFlirtOn = FlirtDialogueQuest.IsRunning()
		SetToggleOptionValueST(IsFlirtOn)
	endEvent
	
	event OnSelectST()
		bool IsFlirtOn = FlirtDialogueQuest.IsRunning()
		if(IsFlirtOn)
			FlirtDialogueQuest.Stop()
		else
			FlirtDialogueQuest.Start()
		endIf
		SetToggleOptionValueST(FlirtDialogueQuest.IsRunning())
	endEvent

	event OnHighlightST()
		SetInfoText("Show <flirt> in chat.")
	endEvent
endState

state StartIntroductionToggle
	event OnDefaultST()
		bool optionOn = IntroductionQuest.IsRunning()
		SetToggleOptionValueST(optionOn)
		if(optionOn)
			;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
	endEvent
	
	event OnSelectST()
		bool optionOn = IntroductionQuest.IsRunning()
		
		if(!optionOn)
			IntroductionQuest.Start()
			;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
		SetToggleOptionValueST(IntroductionQuest.IsRunning())
	endEvent

	event OnHighlightST()
		if(IntroductionQuest.GetCurrentStageID() > 0)
			SetInfoText("Introduction quest is running.")
		else
			SetInfoText("Start introduction quest. You should not do this before DA14.")
		endIf
	endEvent
endState

state HarlotToggle
	event OnDefaultST()
		SetToggleOptionValueST(PlayerRef.HasPerk(HarlotPerk))
	endEvent
	
	event OnSelectST()		
		if(PlayerRef.HasPerk(HarlotPerk))
			Debug.Trace("Removing harlot perk")
			PlayerRef.RemovePerk(HarlotPerk)
		else
			Debug.Trace("Adding harlot perk")
			PlayerRef.AddPerk(HarlotPerk)
		endIf
		SetToggleOptionValueST(DebugHarlot)
	endEvent

	event OnHighlightST()
		SetInfoText("Cheat / debug to become harlot.")
	endEvent
endState

; Debug
state HarlotDebugToggle
	event OnDefaultST()
		SetToggleOptionValueST(DebugHarlot)
	endEvent
	
	event OnSelectST()
		DebugHarlot = !DebugHarlot
		SetToggleOptionValueST(DebugHarlot)
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose harlot related debug.")
	endEvent
endState

state SanguineDebugToggle
	event OnDefaultST()
		SetToggleOptionValueST(DebugSanguine)
	endEvent
	
	event OnSelectST()
		DebugSanguine = !DebugSanguine
		SetToggleOptionValueST(DebugSanguine)
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose sanguine related debug.")
	endEvent
endState

state SuccubusDebugToggle
	event OnDefaultST()
		SetToggleOptionValueST(DebugSuccubus)
	endEvent
	
	event OnSelectST()
		DebugSuccubus = !DebugSuccubus
		SetToggleOptionValueST(DebugSuccubus)
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose succubus related debug.")
	endEvent
endState

state IntroductionQuestDebugToggle
	event OnDefaultST()
		SetToggleOptionValueST(DebugIntroduction)
	endEvent
	
	event OnSelectST()
		DebugIntroduction = !DebugIntroduction
		SetToggleOptionValueST(DebugIntroduction)
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose MoaH_IntroductionQuest related debug.")
	endEvent
endState

state SaveBodyMorphs
	event OnDefaultST()
	endEvent

	event OnSelectST()
		SetOptionFlagsST(OPTION_FLAG_DISABLED)
		string[] names = NiOverride.GetMorphNames(PlayerRef)
		int index = 0
		while index < names.Length
			string morphName = names[index]
			float morphValue = NiOverride.GetMorphValue(PlayerRef,morphName)
			Debug.Trace("Got value " + morphValue + " for " + morphName)
			JSONUtil.SetFloatValue(morphFile, morphName, morphValue)
			index += 1
		endWhile
		JSONUtil.Unload(morphFile, true, false)
		SetOptionFlagsST(0)
		Debug.MessageBox("Save done")
	endEvent
	
	event OnHighlightST()
		SetInfoText("Save current body values as harlot target body values.")
	endEvent
endState