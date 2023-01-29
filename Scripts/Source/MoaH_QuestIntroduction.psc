Scriptname MoaH_QuestIntroduction extends Quest  

MoaH_QuestCommonProperties Property CommonProperties Auto  


bool stage1ToStage2Passed = false
bool stage2ToStage3Passed = false

Actor player

Event OnInit()
	; TODO: Randomize interval
	player = Game.GetPlayer()
	RegisterForUpdateGameTime(1)
EndEvent

event OnLoadGame()
	UnregisterForUpdateGameTime()
	RegisterForUpdateGameTime(1)
endEvent

Event OnUpdateGameTime()
	int iqCSI = GetCurrentStageID()
	bool ThinkingAboutTheCure = iqCSI >= 120 && iqCSI < 160
	int rank = player.GetFactionRank(CommonProperties.HarlotStagesFaction)
	

	
	if (ThinkingAboutTheCure)
		if(rank == 2 && !stage1ToStage2Passed)	
			Debug.MessageBox("My body is warm and tingling and its more difficult to concentrate. I could swear something is happening with my body. Maybe I should ask Tara about this?")
			stage1ToStage2Passed = true
		elseif (rank == 3 && !stage2ToStage3Passed)
			Debug.MessageBox("My hands wonder on my body and its tingling. My nipples are visibly stiff and its difficult to hold the excitement. Its so difficult to think now! What can I do?")
			stage2ToStage3Passed = true
		endIf
	endIf
		
EndEvent