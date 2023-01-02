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

bool DebugHarlot = true
bool DebugSuccubus = true
bool DebugIntroduction = true
bool DebugSanguine = true

bool IsFlirtOn = true

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
		LoadCustomContent("MoaH/title.dds")
		return
	else
		UnloadCustomContent()
	endIf
	
	if(a_page == "$PageGeneral")
		AddHeaderOption("Dialogue")
		AddToggleOptionST("FlirtToggle","$ToggleFlirt", IsFlirtOn)
	elseIf(a_page == "$PageHarlot")
		;AddHeaderOption("Desire")
		AddHeaderOption("$HeaderBodyMorphs")
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
		IsFlirtOn = FlirtDialogueQuest.IsRunning()
		SetToggleOptionValueST(IsFlirtOn)
	endEvent
	
	event OnSelectST()
		IsFlirtOn = !IsFlirtOn
		SetToggleOptionValueST(IsFlirtOn)
		if(IsFlirtOn)
			FlirtDialogueQuest.Start()
		else
			FlirtDialogueQuest.Stop()
		endIf
	endEvent

	event OnHighlightST()
		SetInfoText("Show <flirt> in chat.")
	endEvent
endState

state StartIntroductionToggle
	event OnDefaultST()
		bool optionOn = IntroductionQuest.GetCurrentStageID() > 0
		SetToggleOptionValueST(optionOn)
		if(optionOn)
			SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
	endEvent
	
	event OnSelectST()
		bool optionOn = IntroductionQuest.GetCurrentStageID() > 0
		SetToggleOptionValueST(optionOn)
		if(!optionOn)
			IntroductionQuest.Start()
			SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
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
			PlayerRef.AddPerk(HarlotPerk)
		else
			PlayerRef.RemovePerk(HarlotPerk)
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

