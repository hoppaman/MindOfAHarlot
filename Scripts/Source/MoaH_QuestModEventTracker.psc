Scriptname MoaH_QuestModEventTracker extends MoaH_QuestBase  

MoaH_QuestCommonProperties Property CommonProperties Auto 
MoaH_QuestUtility Property MUtility Auto

Message Property BlowJobQuestion01 Auto

string[] NotAPenis

int[] Last_SLSF_fame

Event OnInit()
	Debug.Trace("[MoaH] ModEventTracker init")
	NotAPenis = new string[5]
	NotAPenis[0] = "SOS No Schlong for Females"
	NotAPenis[1] = "SOS Pubic Hair for Females"
	NotAPenis[2] = "SOS Pubic Hair Wild"
	NotAPenis[3] = "SOS Pubic Hair Landing Strip"
	NotAPenis[4] = "SOS Pubic Hair Untamed"
	;RegisterForModEvent("DeviceActorOrgasm", "OnDDOrgasm")
	RegisterForModEvent("HookOrgasmStart", "OnSexLabOrgasm")
	RegisterForModEvent("HookAnimationStart", "OnSexLabAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnSexLabAnimationEnd")
	RegisterForModEvent("HookStageStart", "OnSexLabStageStart")
	RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Last_SLSF_fame = CommonProperties.SLSF.GetCurrentFameValues()
	RegisterForUpdateGameTime(0.5)
endEvent

function OnLoadGame()
	Debug.Trace("[MoaH] ModEventTracker reloading")
	Debug.Trace("[MoaH] ModEventTracker unsub")
	UnregisterForAllModEvents()
	Debug.Trace("[MoaH] ModEventTracker resub")
	;RegisterForModEvent("DeviceActorOrgasm", "OnDDOrgasm")
	RegisterForModEvent("HookOrgasmStart", "OnSexLabOrgasm")
	RegisterForModEvent("HookAnimationStart", "OnSexLabAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnSexLabAnimationEnd")
	RegisterForModEvent("HookStageStart", "OnSexLabStageStart")
	RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Last_SLSF_fame = CommonProperties.SLSF.GetCurrentFameValues()
	UnregisterForUpdateGameTime()
	RegisterForUpdateGameTime(0.5)
endFunction

Event OnUpdateGameTime()
	Debug.Trace("[MoaH] ModEventTracker update")
	int lastTotal = CalculateSLSFFame(Last_SLSF_fame)
	Last_SLSF_fame = CommonProperties.SLSF.GetCurrentFameValues()
	int current = CalculateSLSFFame(Last_SLSF_fame)
	if(lastTotal < current)
		Debug.Notification("I can hear the growing whispers. They know me as a brainless fuck.")
	endIf
EndEvent


Event OnSexLabOrgasm(int tid, bool hasPlayer)
	Debug.Trace("[MoaH] OnSexlabOrgasm.")
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	Actor[] actors = SexLab.HookActors(tid as string)
	int idx = 0

	While idx < actors.Length
		DetectOrgasmEffect(actors[idx], tid)
		idx += 1
	EndWhile
EndEvent

; SLSO
Event OnSexLabOrgasmSeparate(Actor akActor, int tid)
	Debug.Trace("[MoaH] OnSLSOOrgasm.")
	
		
	DetectOrgasmEffect(akActor, tid)
EndEvent

Function DetectOrgasmEffect(Actor akActor, int tid)
	Debug.Trace("[MoaH] Detect orgasm.")
	SexLabFramework SexLab = SexLabUtil.GetAPI()

	Actor PlayerRef = Game.GetPlayer()
	Actor[] actors = SexLab.HookActors(tid as string)

	sslBaseAnimation animation = SexLab.HookAnimation(tid as string)
	bool involvesPlayer = false
	bool involvesHarlot = false
	bool playerHasCock = false
	bool playerHavingOrgasm = akActor == PlayerRef
	bool notPlayerCockOrgasm = HasCock(akActor) && !playerHavingOrgasm
	
	int idx = 0	
	while idx < actors.Length
		Actor actr = actors[idx]
		if(actr == PlayerRef)
			involvesPlayer = true
			playerHasCock = HasCock(actr)
		endif
		idx += 1
	endWhile
	bool playerGettingFilled = involvesPlayer && notPlayerCockOrgasm
	string heSheCap = "She"
	string heShe = "she"
	if(SexLab.GetGender(akActor) == 0)
		heShe = "he"
		heSheCap = "He"
	endIf			
	
	if (animation.HasTag("Oral"))
		if(playerGettingFilled)
			if(BlowJobQuestion01.Show() > 0)
				; Swallow
				MUtility.AddHarlotScore(PlayerRef, CommonProperties.HarlotScorePerSwallow)
			else
				MUtility.AddHarlotScore(PlayerRef, CommonProperties.HarlotScorePerNormalSex)
			endIf
		endIf
	elseif (animation.HasTag("Anal"))
		if(playerGettingFilled)
			Debug.Notification("MMmm, " + heShe + " came in to my rose!")
			MUtility.AddHarlotScore(PlayerRef, CommonProperties.HarlotScorePerAnal)
		endIf
	elseif(animation.HasTag("Vaginal"))
		if(playerGettingFilled)
			Debug.Notification("MMmm, " + heShe + " came in to my lotus!")
			MUtility.AddHarlotScore(PlayerRef, CommonProperties.HarlotScorePerNormalSex)
		endIf
	endif
	
EndFunction
	
Event OnSexLabStageStart(int tid, bool hasPlayer)
	Debug.Trace("[MoaH] SexLabStageStart")
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	
	;Actor[] actors = SexLab.HookActors(_args)
	;int idx = 0
	;sslBaseAnimation animation = SexLab.HookAnimation(_args)
	
	;if animation.HasTag("Vaginal") && actors.Length > 1
	;
	;endif
EndEvent

Event OnSexlabAnimationStart(int tid, bool hasPlayer)
	Debug.Trace("[MoaH] SexLabAnimationStart")
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	sslThreadController thread = SexLab.GetController(tid)
	if hasPlayer == true
		Actor akActor = Game.GetPlayer()
		; TODO
	endif
EndEvent

Event OnSexlabAnimationEnd(int tid, bool hasPlayer)
	Debug.Trace("[MoaH] SexLabAnimationEnd")
	SexLabFramework SexLab = SexLabUtil.GetAPI()
			
	sslThreadController thread = SexLab.GetController(tid)
	if hasPlayer == true
		; TODO
	endif
EndEvent

bool Function HasCock(Actor akActor)
	bool hasSchlong = false		
	SOS_SetupQuest_Script sosScript = CommonProperties.SOSSetupQuest
	Faction SOS_SchlongifiedFaction = sosScript.SOS_SchlongifiedFaction

	If akActor.IsInFaction(SOS_SchlongifiedFaction)
		Quest addon = sosScript.GetActiveAddon(akActor)
		Faction addonFaction = SOS_Data.GetFaction(addon)
		if addonFaction != none
			;if JsonUtil.StringListFind("/DW/SOS_NotAPenis", "notapenis", addonFaction.getname()) == -1
			if NotAPenis.Find(addonFaction.getname()) == -1
				return hasSchlong
			else
				return akActor.IsInFaction(SOS_SchlongifiedFaction)
			endif
		endif
	endif
	return hasSchlong
EndFunction

int function CalculateSLSFFame(int[] fames)
	int index = 0
	int fameTotal = 0
	While index < fames.Length
		fameTotal += fames[index]
		index += 1
	endWhile
	return fameTotal
EndFunction