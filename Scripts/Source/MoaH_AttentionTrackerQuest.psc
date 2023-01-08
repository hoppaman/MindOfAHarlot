Scriptname MoaH_AttentionTrackerQuest extends Quest  

MoaH_CommonProperties Property CommonProperties Auto
MoaH_Utility Property MUtility Auto

event OnInit()
	RegisterForUpdate(15.0)
endEvent

event OnUpdate()
	Actor player = Game.GetPlayer()
	;Actor[] males = MUtility.FindAdultActorsNear(player, 6000, 0)
	
endEvent