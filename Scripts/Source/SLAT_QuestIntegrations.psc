Scriptname SLAT_QuestIntegrations extends Quest  

{
	Somewhat efficient and/or compatible way to do integrations.
}

; Integrations
SexLabFramework Property SexLab Auto Hidden
slaFrameworkScr Property SLA Auto Hidden

; Optional
Quest Property STA Auto Hidden

event OnInit()
	;SexLab = Game.GetFormFromFile(0x00000D62, "SexLab.esm") as SexLabFramework
	SexLab = SexLabUtil.GetAPI()
	SLA = Game.GetFormFromFile(0x290f, "SexLabAroused.esm") as slaFrameworkScr
	; Only test if STA exists
	STA = Game.GetFormFromFile(0x0D62, "Spank That Ass.esp") as Quest
	
endEvent

