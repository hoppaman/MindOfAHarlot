Scriptname MoaH_ConfigMenuQuest extends SKI_ConfigBase

; Script version ....
;
; History
;

MoaH_CommonProperties property CommonProperties auto

string morphFile = "MoaH_HarlotMorphs.json"

int function GetVersion()
	return 1
endFunction

event OnConfigRegister()
	Debug.Trace("[MoaH] Mind of a Harlot SKY UI registered")
endEvent

event OnConfigInit()
	; Version 1 pages
	Pages = new string[5]
	Pages[0] = "General"
	Pages[1] = "Harlot"
	Pages[2] = "Sanguine"
	Pages[3] = "Succubus"
	Pages[4] = "Debug"
endEvent

event OnConfigOpen()
endEvent

event OnConfigClose()
endEvent

event OnVersionUpdate(int a_version)
	if(a_version > CurrentVersion)
		Debug.Trace("[MoaH] version update old " + CurrentVersion + " new version " + a_version)
	endIf
endEvent

event OnPageReset (string a_page)
	if (a_page == "")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Mind of a Harlot")
		;AddTextOption(1,"Configuration menu","")
		LoadCustomContent("skyui/MoaH/mcm_logo.dds", 258, 95)
		return
	else
		UnloadCustomContent()
	endIf
	
	MoaH_FlirtDialogueQuest FlirtDialogueQuest = CommonProperties.FlirtDialogueQuest
	Actor playerRef = CommonProperties.PlayerRef
	Spell MasturbateAbility = CommonProperties.MasturbateAbility
	Spell FondleAbility = CommonProperties.FondleAbility
	Spell TurnHarlotAbility = CommonProperties.TurnHarlotAbility
	MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
	bool DebugHarlot = CommonProperties.DebugHarlot
	bool DebugSanguine = CommonProperties.DebugSanguine
	bool DebugSuccubus = CommonProperties.DebugSuccubus
	bool DebugIntroduction = CommonProperties.DebugIntroduction
	
	if(a_page == "General")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Dialogue")
		AddToggleOptionST("FlirtToggle","Enable Flirt", FlirtDialogueQuest.IsRunning())
		AddEmptyOption()
		AddHeaderOption("Abilities")
		AddToggleOptionST("ToggleFondleAbility", "Add/remove fondle", PlayerRef.HasSpell(FondleAbility))
		AddToggleOptionST("ToggleMasturbateAbility", "Add/remove masturbate", PlayerRef.HasSpell(MasturbateAbility))
		AddEmptyOption()
	elseIf(a_page == "Harlot")
		SetCursorFillMode(TOP_TO_BOTTOM)
		bool playerIsHarlot = false
		string yesNo = "No"
		if(PlayerRef.HasSpell(TurnHarlotAbility))
			yesNo = "Yes"
			playerIsHarlot = true
		endIf
		AddTextOptionST("DisplayHarlotST","Is player harlot?",yesNo)
		int opt = OPTION_FLAG_DISABLED
		if(playerIsHarlot)
			opt = 0
		endIf
		AddHeaderOption("Progress", opt)
		AddTextOptionST("DisplayDesireST","Current desire level", "-",opt)
		AddEmptyOption()
		AddHeaderOption("BodyMorphs")
		AddTextOptionST("SaveBodyMorphs","Current body morph values", "Save")
		AddEmptyOption()
		;AddHeaderOption("Debug")
	elseIf(a_page == "Sanguine")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Standing")
		AddEmptyOption()
		AddHeaderOption("Sanguine chores")
		AddEmptyOption()
		;AddHeaderOption("Debug")
	elseIf(a_page == "Succubus")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Skills")
		AddEmptyOption()
		AddHeaderOption("Curse")
		AddEmptyOption()
		;AddHeaderOption("Debug")
	elseIf(a_page == "Debug")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Introduction")
		AddToggleOptionST("IntroductionQuestDebugToggle","Toggle Introduction Quest Debug",DebugIntroduction)
		AddToggleOptionST("StartIntroductionToggle", "Introduction started",IntroductionQuest.GetCurrentStageID() > 0)
		AddEmptyOption()
		AddHeaderOption("Harlot")
		AddToggleOptionST("HarlotDebugToggle","Toggle Harlot Debug",DebugHarlot)
		AddToggleOptionST("HarlotToggle", "You are a harlot", PlayerRef.HasSpell(TurnHarlotAbility))
		AddEmptyOption()
		AddHeaderOption("Sanguine")
		AddToggleOptionST("SanguineDebugToggle","Toggle Sanguine Debug",DebugSanguine)
		AddEmptyOption()
		AddHeaderOption("Succubus")
		AddToggleOptionST("SuccubusDebugToggle","Toggle Succubus Debug",DebugSuccubus)
		AddEmptyOption()
	else
		; unknown
	endIf
	
endEvent

state FlirtToggle
	event OnDefaultST()
		MoaH_FlirtDialogueQuest FlirtDialogueQuest = CommonProperties.FlirtDialogueQuest
		bool IsFlirtOn = FlirtDialogueQuest.IsRunning()
		SetToggleOptionValueST(IsFlirtOn)
	endEvent
	
	event OnSelectST()
		MoaH_FlirtDialogueQuest FlirtDialogueQuest = CommonProperties.FlirtDialogueQuest
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

state ToggleMasturbateAbility
	event OnDefaultST()
		; Default 
		Actor playerRef = CommonProperties.PlayerRef
		Spell MasturbateAbility = CommonProperties.MasturbateAbility
		if(!PlayerRef.HasSpell(MasturbateAbility))
			PlayerRef.AddSpell(MasturbateAbility)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(MasturbateAbility))
	endEvent
	event OnSelectST()
		Actor playerRef = CommonProperties.PlayerRef
		Spell MasturbateAbility = CommonProperties.MasturbateAbility
		if(PlayerRef.HasSpell(MasturbateAbility))
			PlayerRef.RemoveSpell(MasturbateAbility)
		else
			PlayerRef.AddSpell(MasturbateAbility)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(MasturbateAbility))
	endEvent
	event OnHighlightST()
		SetInfoText("Add/remove masturbate ability.")
	endEvent
endState

state ToggleFondleAbility
	event OnDefaultST()
		; Default 
		Actor playerRef = CommonProperties.PlayerRef
		Spell FondleAbility = CommonProperties.FondleAbility
		if(!PlayerRef.HasSpell(FondleAbility))
			PlayerRef.AddSpell(FondleAbility)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(FondleAbility))
	endEvent
	event OnSelectST()
		Actor playerRef = CommonProperties.PlayerRef
		Spell FondleAbility = CommonProperties.FondleAbility
		if(PlayerRef.HasSpell(FondleAbility))
			PlayerRef.RemoveSpell(FondleAbility)
		else
			PlayerRef.AddSpell(FondleAbility)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(FondleAbility))
	endEvent
	event OnHighlightST()
		SetInfoText("Add/remove masturbate ability.")
	endEvent
endState

state DisplayDesireST
	event OnDefaultST()
		Actor playerRef = CommonProperties.PlayerRef
		Perk HarlotPerk = CommonProperties.HarlotPerk
		if(PlayerRef.HasPerk(HarlotPerk))
			
			if(PlayerRef.HasKeyword(CommonProperties.DesireStage3))
				SetTextOptionValueST("3")
			elseif(PlayerRef.HasKeyword(CommonProperties.DesireStage2))
				SetTextOptionValueST("2")
			elseif(PlayerRef.HasKeyword(CommonProperties.DesireStage1))
				SetTextOptionValueST("1")
			endIf
		else
			SetTextOptionValueST("-")
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("Players current harlot desire. [0,1]")
	endEvent
endState

state StartIntroductionToggle
	event OnDefaultST()
		MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
		bool optionOn = IntroductionQuest.IsRunning()
		SetToggleOptionValueST(optionOn)
		if(optionOn)
			;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
	endEvent
	
	event OnSelectST()
		MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
		bool optionOn = IntroductionQuest.IsRunning()
		if(!optionOn)
			IntroductionQuest.Start()
			;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
		SetToggleOptionValueST(IntroductionQuest.IsRunning())
	endEvent

	event OnHighlightST()
		MoaH_IntroductionQuest IntroductionQuest = CommonProperties.IntroductionQuest
		if(IntroductionQuest.IsRunning())
			SetInfoText("Introduction quest is running.")
		else
			SetInfoText("Start introduction quest. You should not do this before DA14.")
		endIf
	endEvent
endState

state HarlotToggle
	event OnDefaultST()
		Actor playerRef = CommonProperties.PlayerRef
		Spell TurnHarlotAbility = CommonProperties.TurnHarlotAbility
		SetToggleOptionValueST(PlayerRef.HasSpell(TurnHarlotAbility))
	endEvent
	
	event OnSelectST()
		Actor playerRef = CommonProperties.PlayerRef
		Spell TurnHarlotAbility = CommonProperties.TurnHarlotAbility
		if(PlayerRef.HasSpell(TurnHarlotAbility))
			Debug.Trace("[MoaH] Removing harlot")
			PlayerRef.RemoveSpell(TurnHarlotAbility)
		else
			Debug.Trace("[MoaH] Adding harlot")
			PlayerRef.AddSpell(TurnHarlotAbility)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(TurnHarlotAbility))
	endEvent

	event OnHighlightST()
		SetInfoText("Cheat / debug to become harlot.")
	endEvent
endState

; Debug
state HarlotDebugToggle
	event OnDefaultST()
		bool DebugHarlot = CommonProperties.DebugHarlot
		SetToggleOptionValueST(DebugHarlot)
	endEvent
	
	event OnSelectST()
		bool DebugHarlot = CommonProperties.DebugHarlot
		DebugHarlot = !DebugHarlot
		SetToggleOptionValueST(DebugHarlot)
		CommonProperties.DebugHarlot = DebugHarlot
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose harlot related debug.")
	endEvent
endState

state SanguineDebugToggle
	event OnDefaultST()
		bool DebugSanguine = CommonProperties.DebugSanguine
		SetToggleOptionValueST(DebugSanguine)
	endEvent
	
	event OnSelectST()
		bool DebugSanguine = CommonProperties.DebugSanguine
		DebugSanguine = !DebugSanguine
		SetToggleOptionValueST(DebugSanguine)
		CommonProperties.DebugSanguine = DebugSanguine
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose sanguine related debug.")
	endEvent
endState

state SuccubusDebugToggle
	event OnDefaultST()
		bool DebugSuccubus = CommonProperties.DebugSuccubus
		SetToggleOptionValueST(DebugSuccubus)
	endEvent
	
	event OnSelectST()
		bool DebugSuccubus = CommonProperties.DebugSuccubus
		DebugSuccubus = !DebugSuccubus
		SetToggleOptionValueST(DebugSuccubus)
		CommonProperties.DebugSuccubus = DebugSuccubus
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose succubus related debug.")
	endEvent
endState

state IntroductionQuestDebugToggle
	event OnDefaultST()
		bool DebugIntroduction = CommonProperties.DebugIntroduction
		SetToggleOptionValueST(DebugIntroduction)
	endEvent
	
	event OnSelectST()
		bool DebugIntroduction = CommonProperties.DebugIntroduction
		DebugIntroduction = !DebugIntroduction
		SetToggleOptionValueST(DebugIntroduction)
		CommonProperties.DebugIntroduction = DebugIntroduction
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose MoaH_IntroductionQuest related debug.")
	endEvent
endState

state SaveBodyMorphs
	event OnDefaultST()
	endEvent

	event OnSelectST()
		Actor playerRef = CommonProperties.PlayerRef
		;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		string[] names = NiOverride.GetMorphNames(PlayerRef)
		int index = 0
		while index < names.Length
			string morphName = names[index]
			float morphValue = NiOverride.GetMorphValue(PlayerRef,morphName)
			Debug.Trace("[MoaH] Got value " + morphValue + " for " + morphName)
			JSONUtil.SetFloatValue(morphFile, morphName, morphValue)
			index += 1
		endWhile
		JSONUtil.Unload(morphFile, true, false)
		;SetOptionFlagsST(0)
		Debug.MessageBox("[MoaH] Save done")
	endEvent
	
	event OnHighlightST()
		SetInfoText("Save current body values as harlot target body values.")
	endEvent
endState