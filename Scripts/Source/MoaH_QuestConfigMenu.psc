Scriptname MoaH_QuestConfigMenu extends SKI_ConfigBase

; Script version ....
;
; History
;

MoaH_QuestCommonProperties property CommonProperties auto


int function GetVersion()
	return 2
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
		Actor player = Game.GetPlayer()
		if(player.HasSpell(CommonProperties.TurnHarlotAbility))
			player.RemoveSpell(CommonProperties.TurnHarlotAbility)
			player.AddSpell(CommonProperties.TurnHarlotAbility)
		endIf
	endIf
endEvent

event OnPageReset (string a_page)
	if (a_page == "")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Mind of a Harlot")
		;AddTextOption(1,"Configuration menu","")
		LoadCustomContent("SkyUI/MoaH/mcm_logo.dds", 258, 95)
		return
	else
		UnloadCustomContent()
	endIf
	
	;MoaH_FlirtDialogueQuest FlirtDialogueQuest = CommonProperties.FlirtDialogueQuest
	Actor playerRef = Game.GetPlayer()
	Spell TurnHarlotAbility = CommonProperties.TurnHarlotAbility
	MoaH_QuestIntroduction IntroductionQuest = CommonProperties.IntroductionQuest
	
	bool DebugHarlot = CommonProperties.SettingDebugHarlot
	bool DebugSanguine = CommonProperties.SettingDebugSanguine
	bool DebugSuccubus = CommonProperties.SettingDebugSuccubus
	bool DebugIntroduction = CommonProperties.SettingDebugIntroduction
	
	if(a_page == "General")
		
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
		AddTextOptionST("DisplaySexAddictionST","Current harlot stage", "-",opt)
		AddSliderOptionST("SetHarlotScore", "Set harlot score", PlayerRef.GetFactionRank(CommonProperties.HarlotScoreFaction),opt)
		AddEmptyOption()
		AddHeaderOption("BodyMorphs")
		AddTextOptionST("SaveBodyMorphs","Current body morph values", "Save", OPTION_FLAG_DISABLED)
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
		AddHeaderOption("Common")
		AddTextOptionST("ResetModEventTracker", "Reset mod event tracker.", "Reset")
	else
		; unknown
	endIf
	
endEvent


state DisplaySexAddictionST
	event OnDefaultST()
		Actor playerRef = Game.GetPlayer()
		Spell HarlotAbility = CommonProperties.TurnHarlotAbility
		if(PlayerRef.HasSpell(HarlotAbility))
		; TODO:
			SetTextOptionValueST("-")
		endIf
	endEvent
	event OnHighlightST()
		SetInfoText("Players current harlot desire. [0,1]")
	endEvent
endState

state SetHarlotScore
		
	event OnSliderOpenST()
		Actor playerRef = Game.GetPlayer()
		SetSliderDialogStartValue(PlayerRef.GetFactionRank(CommonProperties.HarlotScoreFaction) as float)
		SetSliderDialogDefaultValue(PlayerRef.GetFactionRank(CommonProperties.HarlotScoreFaction) as float)
		SetSliderDialogRange(0, CommonProperties.HarlotScoreMaxRank as float)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		Actor playerRef = Game.GetPlayer()
		PlayerRef.SetFactionRank(CommonProperties.HarlotScoreFaction, value as int)
		SetSliderOptionValueST(PlayerRef.GetFactionRank(CommonProperties.HarlotScoreFaction) as float)
	endEvent

	event OnDefaultST()
		Actor playerRef = Game.GetPlayer()
		SetSliderOptionValueST(PlayerRef.GetFactionRank(CommonProperties.HarlotScoreFaction) as float)
	endEvent

	event OnHighlightST()
		SetInfoText("Set harlot score.")
	endEvent
endState

state StartIntroductionToggle
	event OnDefaultST()
		MoaH_QuestIntroduction IntroductionQuest = CommonProperties.IntroductionQuest
		bool optionOn = IntroductionQuest.IsRunning()
		SetToggleOptionValueST(optionOn)
		if(optionOn)
			;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
	endEvent
	
	event OnSelectST()
		MoaH_QuestIntroduction IntroductionQuest = CommonProperties.IntroductionQuest
		bool optionOn = IntroductionQuest.IsRunning()
		if(!optionOn)
			IntroductionQuest.Start()
			;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		endIf
		SetToggleOptionValueST(IntroductionQuest.IsRunning())
	endEvent

	event OnHighlightST()
		MoaH_QuestIntroduction IntroductionQuest = CommonProperties.IntroductionQuest
		if(IntroductionQuest.IsRunning())
			SetInfoText("Introduction quest is running.")
		else
			SetInfoText("Start introduction quest. You should not do this before DA14.")
		endIf
	endEvent
endState

state HarlotToggle
	event OnDefaultST()
		Actor playerRef = Game.GetPlayer()
		Spell TurnHarlotAbility = CommonProperties.TurnHarlotAbility
		SetToggleOptionValueST(PlayerRef.HasSpell(TurnHarlotAbility))
	endEvent
	
	event OnSelectST()
		Actor playerRef = Game.GetPlayer()
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
		bool DebugHarlot = CommonProperties.SettingDebugHarlot
		SetToggleOptionValueST(DebugHarlot)
	endEvent
	
	event OnSelectST()
		bool DebugHarlot = CommonProperties.SettingDebugHarlot
		DebugHarlot = !DebugHarlot
		SetToggleOptionValueST(DebugHarlot)
		CommonProperties.SettingDebugHarlot = DebugHarlot
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose harlot related debug.")
	endEvent
endState

state ResetModEventTracker
	event OnDefaultST()
		SetTextOptionValueST("RESET")
	endEvent
	
	event OnSelectST()
		CommonProperties.ModEventTrackerQuest.Stop()
		Utility.Wait(1.0)
		CommonProperties.ModEventTrackerQuest.Reset()
		Utility.Wait(1.0)
		CommonProperties.ModEventTrackerQuest.Start()
	endEvent
	
	event OnHighlightST()
		SetInfoText("Reset event tracker.")
	endEvent
endState

state SanguineDebugToggle
	event OnDefaultST()
		bool DebugSanguine = CommonProperties.SettingDebugSanguine
		SetToggleOptionValueST(DebugSanguine)
	endEvent
	
	event OnSelectST()
		bool DebugSanguine = CommonProperties.SettingDebugSanguine
		DebugSanguine = !DebugSanguine
		SetToggleOptionValueST(DebugSanguine)
		CommonProperties.SettingDebugSanguine = DebugSanguine
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose sanguine related debug.")
	endEvent
endState

state SuccubusDebugToggle
	event OnDefaultST()
		bool DebugSuccubus = CommonProperties.SettingDebugSuccubus
		SetToggleOptionValueST(DebugSuccubus)
	endEvent
	
	event OnSelectST()
		bool DebugSuccubus = CommonProperties.SettingDebugSuccubus
		DebugSuccubus = !DebugSuccubus
		SetToggleOptionValueST(DebugSuccubus)
		CommonProperties.SettingDebugSuccubus = DebugSuccubus
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose succubus related debug.")
	endEvent
endState

state IntroductionQuestDebugToggle
	event OnDefaultST()
		bool DebugIntroduction = CommonProperties.SettingDebugIntroduction
		SetToggleOptionValueST(DebugIntroduction)
	endEvent
	
	event OnSelectST()
		bool DebugIntroduction = CommonProperties.SettingDebugIntroduction
		DebugIntroduction = !DebugIntroduction
		SetToggleOptionValueST(DebugIntroduction)
		CommonProperties.SettingDebugIntroduction = DebugIntroduction
	endEvent

	event OnHighlightST()
		SetInfoText("Verbose MoaH_QuestIntroduction related debug.")
	endEvent
endState

state SaveBodyMorphs
	event OnDefaultST()
	endEvent

	event OnSelectST()
		string morphFile = "MoaH_HarlotCustomMorphs.json"
		Actor playerRef = Game.GetPlayer()
		;SetOptionFlagsST(OPTION_FLAG_DISABLED)
		JSONUtil.Load(morphFile)
		;JSONUtil.ClearAll(morphFile)
		string[] names = NiOverride.GetMorphNames(playerRef)
		int indexNames = 0
		int indexKeys = 0
		while indexNames < names.Length
			string morphName = names[indexNames]
			; This was bullshit
			;string[] keys = NiOverride.GetMorphKeys(playerRef,morphName)
			;while indexKeys < keys.Length
			;	string keyName = keys[indexKeys]
			;	float morphValue = NiOverride.GetBodyMorph(playerRef,morphName, keyName)
			;	Debug.Trace("[MoaH] Got value " + morphValue + " for morph " + morphName + ";;" + keyName)
			;	JSONUtil.SetFloatValue(morphFile, morphName+";;"+keyName, morphValue)
			;	indexKeys += 1
			;endWhile
			
			float morphValue = NiOverride.GetMorphValue(playerRef,morphName)
			Debug.Trace("[MoaH] Got value " + morphValue + " for morph " + morphName)
			JSONUtil.SetFloatValue(morphFile, morphName, morphValue)

			indexNames += 1
		endWhile
		JSONUtil.Unload(morphFile, true, false)
		;SetOptionFlagsST(0)
		Debug.MessageBox("[MoaH] Save done")
	endEvent
	
	event OnHighlightST()
		SetInfoText("Save current body values as harlot target body values.")
	endEvent
endState