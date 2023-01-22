Scriptname SLAT_RefSpectator extends ReferenceAlias  

SLAT_QuestCommonProperties Property CommonProperties auto



; Long reach
float longReachDistance = 5000.0
bool PlayerWasNaked = false
bool PlayerWasHavingSex = false

; Mid reach
float midReachDistance = 3000.0
bool PlayerWasTeasing = false

; Close reach
float closeReachDistance = 1000.0
bool PlayerHadCum = false

Actor a
Actor player
SexLabFramework SexLab

bool ActorLikesPlayer
float timer = 0.0
float updateDelta = 5.0


event OnInit()
	SexLab = SexLabUtil.GetAPI()
	player = Game.GetPlayer()
endEvent
	
event OnReset()
	timer = 0.0
	a = GetActorRef()
	if(!a)
		Debug.Trace("[SLAT] spectator did not get correct reference.")
		return
	endIf
	Debug.Notification("[SLAT] New spectator " + a.GetDisplayName())
	a.AddSpell(CommonProperties.MarkSpectatorAbility)
	
	ActorLikesPlayer = COMMON_Utility.IsAIntoB(a, player)
	RegisterForSingleUpdate(updateDelta)
	UpdateVision()
endEvent

event OnUpdate()
	; needed to see if alias still points to right actor
	a = GetActorRef()
	if(!a || a.IsDead() || player.IsDead() || a.GetParentCell() != player.GetParentCell())
		; Terminated
		Clear()
		return
	endIf
	
	timer += updateDelta
	
	bool reasonForFocus = UpdateVision()

	bool intrestTimerEnding = timer > 45.0
	bool LOSLost = !COMMON_Utility.DoesASeeB(a, player)
	
	if(intrestTimerEnding)
		Debug.Notification("[SLAT] " + a.GetDisplayName() + " timer ending.")
	endIf
	
	if(LOSLost)
		Debug.Notification("[SLAT] " + a.GetDisplayName() + " lost LOS.")
	endIf
	
	if(!reasonForFocus)
		Debug.Notification("[SLAT] " + a.GetDisplayName() + " has no reason for focus. ")
	endIf
	
	if(intrestTimerEnding || LOSLost || !reasonForFocus)
		a.ClearLookAt()
		Clear()
	else
		RegisterForSingleUpdate(updateDelta)
	endIf
endEvent


bool function UpdateVision()
	float distance = player.GetDistance(a)
	
	if(distance <= closeReachDistance)
		reasonForFocus = UpdateCloseReach() || reasonForFocus
	endIf
	
	if(reasonForFocus)
		a.SetLookAt(player, true)
	endIf
	
	if(distance <= midReachDistance)
		reasonForFocus = UpdateMidReach() || reasonForFocus
	endIf
	
	bool reasonForFocus = false
	if(distance <= longReachDistance)
		reasonForFocus = UpdateLongReach() || reasonForFocus
	endIf
	
	return reasonForFocus
endFunction

;return if there is reason for attention
bool Function UpdateLongReach()
	bool playerIsNaked = CommonProperties.PlayerIsNaked
	bool playerIsHavingSex = CommonProperties.PlayerIsHavingSex

	if(!PlayerWasNaked && playerIsNaked)
		Debug.Notification("[SLAT] Player became naked. " + a.GetDisplayName())
		PlayerWasNaked = true
	endIf
	
	if(!PlayerWasHavingSex && playerIsHavingSex)
		Debug.Notification("[SLAT] Player started having sex. " + a.GetDisplayName())
		PlayerWasHavingSex = true
	endIf
	
	return playerIsHavingSex || (playerIsNaked && ActorLikesPlayer)
endFunction

;return if there is reason for attention
bool Function UpdateMidReach()
	bool playerIsTeasing = CommonProperties.PlayerIsTeasing

	if(!PlayerWasTeasing && playerIsTeasing)
		Debug.Notification(""+ a.GetDisplayName() + " sees player is teasing.")
		PlayerWasTeasing = true
	endIf
	
	return playerIsTeasing
endFunction

;return if there is reason for attention
bool Function UpdateCloseReach()
	bool playerHasCum = CommonProperties.PlayerHasCumOn
	if(!PlayerHadCum && playerHasCum)
		Debug.Notification(""+ a.GetDisplayName() + " sees cum on player.")
		PlayerHadCum = true
	endIf
	return playerHasCum
endFunction
	