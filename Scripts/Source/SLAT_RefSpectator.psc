Scriptname SLAT_RefSpectator extends ReferenceAlias  

SLAT_QuestCommonProperties Property CommonProperties auto

float timer = 0.0

bool ActorLikesPlayer
bool PlayerWasNaked
bool PlayerWasTeasing

event OnInit()
	Actor a = GetActorRef()
	Debug.Notification("[SLAT] New spectator " + a.GetDisplayName())
	
	Actor player = Game.GetPlayer()
	PlayerWasNaked = CommonProperties.PlayerIsNaked
	PlayerWasTeasing = CommonProperties.PlayerIsTeasing
	ActorLikesPlayer = COMMON_Utility.IsAIntoB(a, player)
	RegisterForUpdate(5)
endEvent

event OnUpdate()
	timer += 5
	Actor a = GetActorRef()
	Actor player = Game.GetPlayer()
	bool playerIsNaked = CommonProperties.PlayerIsNaked
	
	bool playerIsTeasing = CommonProperties.PlayerIsTeasing

	bool stoppedNaked = PlayerWasNaked && !playerIsNaked
	bool stoppedTeasing = PlayerWasTeasing && !playerIsTeasing

	if(timer > 45.0 || !COMMON_Utility.DoesASeeB(a, player) || (ActorLikesPlayer && (stoppedNaked || stoppedTeasing)))
		Debug.Notification("[SLAT] " + a.GetDisplayName() + " lost interest.")
		Clear()
	endIf
endEvent