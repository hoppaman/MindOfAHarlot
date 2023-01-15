Scriptname SLAT_QuestConfigMenu extends SKI_ConfigBase  

SLAT_QuestCommonProperties Property CommonProperties Auto

int function GetVersion()
	return 1
endFunction

event OnConfigRegister()
	Debug.Trace("[SLAT] SL Attention and Thoughts menu registered.")
endEvent

event OnConfigInit()
	; Version 1 pages
	Pages = new string[1]
	Pages[0] = "General"
endEvent

event OnConfigOpen()
endEvent

event OnConfigClose()
endEvent

event OnVersionUpdate(int a_version)
	if(a_version > CurrentVersion)
		Debug.Trace("[SLAT] version update old " + CurrentVersion + " new version " + a_version)
	endIf
endEvent

event OnPageReset (string a_page)
	if (a_page == "")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("SexLab: Attention and Thoughts ")
		;AddTextOption(1,"Configuration menu","")
		;LoadCustomContent("skyui/MoaH/mcm_logo.dds", 258, 95)
		return
	else
		UnloadCustomContent()
	endIf
	Actor PlayerRef = Game.GetPlayer()
	Spell MasturbatePower = CommonProperties.MasturbatePower
	Spell TeasePower = CommonProperties.TeasePower
	
	SLAT_QuestThoughts ThoughtsQuest = CommonProperties.ThoughtsQuest

	if(a_page == "General")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Dialogue")
		;AddToggleOptionST("FlirtToggle","Enable Flirt", FlirtDialogueQuest.IsRunning())
		AddEmptyOption()
		AddHeaderOption("Thoughts")
		AddToggleOptionST("ThoughtsToggle","Enable Thoughts", ThoughtsQuest.IsRunning())
		AddSliderOptionST("ThoughtsInterval","Thoughts interval (seconds)", CommonProperties.SettingThoughtsInterval)
		AddEmptyOption()
		AddHeaderOption("Abilities")
		AddToggleOptionST("ToggleTeasePower", "Add/remove fondle", PlayerRef.HasSpell(TeasePower))
		AddToggleOptionST("ToggleMasturbatePower", "Add/remove masturbate", PlayerRef.HasSpell(MasturbatePower))
		AddEmptyOption()
		bool debugComments = CommonProperties.DebugCommentsGlobal.GetValueInt() == 1
		AddToggleOptionST("CommentsDebugToggle", "Show debug dialogue", debugComments)
		
	endIf
	
endEvent

state FlirtToggle
	event OnDefaultST()
		;MoaH_FlirtDialogueQuest FlirtDialogueQuest = CommonProperties.FlirtDialogueQuest
		;bool IsFlirtOn = FlirtDialogueQuest.IsRunning()
		;SetToggleOptionValueST(IsFlirtOn)
	endEvent
	
	event OnSelectST()
		;MoaH_FlirtDialogueQuest FlirtDialogueQuest = CommonProperties.FlirtDialogueQuest
		;bool IsFlirtOn = FlirtDialogueQuest.IsRunning()
		;if(IsFlirtOn)
		;	FlirtDialogueQuest.Stop()
		;else
		;	FlirtDialogueQuest.Reset()
		;	if(!FlirtDialogueQuest.Start())
		;		Debug.Trace("[MoaH] failed to start Flirt")
		;	endIf
		;endIf
		;SetToggleOptionValueST(FlirtDialogueQuest.IsRunning())
	endEvent

	event OnHighlightST()
		;SetInfoText("Show <flirt> in chat.")
	endEvent
endState

state ThoughtsToggle
	event OnDefaultST()
		SLAT_QuestThoughts thoughtsQuest = CommonProperties.ThoughtsQuest
		bool IsOn = thoughtsQuest.IsRunning()
		SetToggleOptionValueST(IsOn)
	endEvent
	
	event OnSelectST()
		SLAT_QuestThoughts thoughtsQuest = CommonProperties.ThoughtsQuest
		bool IsOn = thoughtsQuest.IsRunning()
		if(IsOn)
			thoughtsQuest.Stop()
		else
			thoughtsQuest.Reset()
			if(!thoughtsQuest.Start())
				Debug.Trace("[MoaH] failed to start thoughts")
			endIf
		endIf
		SetToggleOptionValueST(thoughtsQuest.IsRunning())
	endEvent

	event OnHighlightST()
		SetInfoText("Player thoughts on/off")
	endEvent
endState

state ThoughtsInterval
	event OnSliderOpenST()
		SetSliderDialogStartValue(CommonProperties.SettingThoughtsInterval)
		SetSliderDialogDefaultValue(CommonProperties.SettingThoughtsInterval)
		SetSliderDialogRange(12, 300)
		SetSliderDialogInterval(1)
	endEvent

	event OnSliderAcceptST(float value)
		CommonProperties.SettingThoughtsInterval = value
		SetSliderOptionValueST(CommonProperties.SettingThoughtsInterval)
	endEvent

	event OnDefaultST()
		SetSliderOptionValueST(CommonProperties.SettingThoughtsInterval)
	endEvent

	event OnHighlightST()
		SetInfoText("In seconds how often thoughts should update.")
	endEvent
endState

state ToggleMasturbatePower
	event OnDefaultST()
		; Default 
		Actor playerRef = Game.GetPlayer()
		Spell MasturbatePower = CommonProperties.MasturbatePower
		if(!PlayerRef.HasSpell(MasturbatePower))
			PlayerRef.AddSpell(MasturbatePower)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(MasturbatePower))
	endEvent
	event OnSelectST()
		Actor playerRef = Game.GetPlayer()
		Spell MasturbatePower = CommonProperties.MasturbatePower
		if(PlayerRef.HasSpell(MasturbatePower))
			PlayerRef.RemoveSpell(MasturbatePower)
		else
			PlayerRef.AddSpell(MasturbatePower)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(MasturbatePower))
	endEvent
	event OnHighlightST()
		SetInfoText("Add/remove masturbate ability.")
	endEvent
endState

state ToggleTeasePower
	event OnDefaultST()
		; Default 
		Actor playerRef = Game.GetPlayer()
		Spell TeasePower = CommonProperties.TeasePower
		if(!PlayerRef.HasSpell(TeasePower))
			PlayerRef.AddSpell(TeasePower)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(TeasePower))
	endEvent
	event OnSelectST()
		Actor playerRef = Game.GetPlayer()
		Spell TeasePower = CommonProperties.TeasePower
		if(PlayerRef.HasSpell(TeasePower))
			PlayerRef.RemoveSpell(TeasePower)
		else
			PlayerRef.AddSpell(TeasePower)
		endIf
		SetToggleOptionValueST(PlayerRef.HasSpell(TeasePower))
	endEvent
	event OnHighlightST()
		SetInfoText("Add/remove masturbate ability.")
	endEvent
endState

state CommentsDebugToggle
	event OnDefaultST()
		bool debugComments = CommonProperties.DebugCommentsGlobal.GetValueInt() == 1
		SetToggleOptionValueST(debugComments)
	endEvent
	
	event OnSelectST()
		bool debugComments = CommonProperties.DebugCommentsGlobal.GetValueInt() == 1
		debugComments = !debugComments
		SetToggleOptionValueST(debugComments)
		if(debugComments)
			CommonProperties.DebugCommentsGlobal.SetValueInt(1)
		else
			CommonProperties.DebugCommentsGlobal.SetValueInt(0)
		endIf
	endEvent

	event OnHighlightST()
		SetInfoText("Adds debug lines to NPCS")
	endEvent
endState