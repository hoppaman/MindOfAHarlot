Scriptname SLAT_QuestIntegrations extends Quest  

{
	Somewhat efficient and/or compatible way to do integrations.
}

; Integrations
; HARD
SexLabFramework Property SexLab Auto
slaFrameworkScr Property SLA Auto

Faction Property SLA_NakedFaction Auto
Faction Property SLA_ArousalFaction Auto

; Soft
Quest Property STA Auto Hidden

event OnInit()
	; Only test if STA exists
	STA = Game.GetFormFromFile(0x0D62, "Spank That Ass.esp") as Quest
	
endEvent

int Function GetArousal(Actor akActor)
	return akActor.GetFactionRank(SLA_ArousalFaction)
endFunction

bool Function IsNaked(Actor akActor)
	return akActor.GetFactionRank(SLA_NakedFaction) >= 0
endFunction

