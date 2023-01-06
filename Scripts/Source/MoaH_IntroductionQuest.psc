Scriptname MoaH_IntroductionQuest extends Quest  

MoaH_CommonProperties Property CommonProperties Auto  

Event OnInit()
	; TODO: Randomize interval

EndEvent

event OnLoadGame()
	UnregisterForUpdateGameTime()
	RegisterForUpdateGameTime(1)
endEvent

Event OnUpdateGameTime()
	Actor PlayerRef = CommonProperties.PlayerRef
	Keyword DesireStage1 = CommonProperties.HarlotSexAddictionStage1Keyword
	Keyword DesireStage2 = CommonProperties.HarlotSexAddictionStage2Keyword
	Keyword DesireStage3 = CommonProperties.HarlotSexAddictionStage3Keyword
	int iqCSI = GetCurrentStageID()
	
	bool ThinkingAboutTheCure = iqCSI >= 120 && iqCSI < 160
	
	if (ThinkingAboutTheCure)
		if(PlayerRef.HasKeyword(DesireStage2))
			; TODO: Different messages
			Debug.MessageBox("My hands have wondered on my breasts and I was fondling them. Its getting worse!")	
		elseif (PlayerRef.HasKeyword(DesireStage3))
			; TODO: Different messages
			Debug.MessageBox("My hands wonder on my body and its tingling. My nipples are visibly stiff and its difficult to hold the excitement. Its so difficult to think now!")
		endIf
	endIf
		
EndEvent