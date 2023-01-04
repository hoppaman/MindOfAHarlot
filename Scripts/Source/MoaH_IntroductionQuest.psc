Scriptname MoaH_IntroductionQuest extends Quest  

MoaH_CommonProperties Property CommonProperties Auto  

Event OnInit()
	; TODO: Randomize interval
	RegisterForUpdateGameTime(1)
EndEvent

Event OnUpdateGameTime()
	Actor PlayerRef = CommonProperties.PlayerRef
	Keyword DesireStage1 = CommonProperties.DesireStage1
	Keyword DesireStage2 = CommonProperties.DesireStage2
	Keyword DesireStage3 = CommonProperties.DesireStage3
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
	else
		if(PlayerRef.HasKeyword(DesireStage3))
			Debug.Notification("I am being so wet its not nice to walk.")
		elseif(PlayerRef.HasKeyword(DesireStage2))
			Debug.Notification("mmm, how I get this itch off?")
		elseif(PlayerRef.HasKeyword(DesireStage1))
			Debug.Notification("Where are all the willing men!")
		endif
	endIf
		
EndEvent