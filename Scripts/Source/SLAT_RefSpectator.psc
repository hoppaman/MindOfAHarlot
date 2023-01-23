Scriptname SLAT_RefSpectator extends ReferenceAlias  

SLAT_QuestCommonProperties Property CommonProperties auto
SLAT_QuestIntegrations Property Integrations auto


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

; Can touch
float canTouchDistance = 200.0


Actor a
Actor player
SexLabFramework SexLab

bool ActorFanciesPlayer
bool IsSexist
float timer = 0.0
float updateDelta = 6.0
int arousal

event OnInit()
	SexLab = SexLabUtil.GetAPI()
	player = Game.GetPlayer()
endEvent
	
event BootUp()
	timer = 0.0
	a = GetActorRef()
	if(!a)
		Debug.Trace("[SLAT] spectator did not get correct reference.")
		return
	endIf
	Debug.Notification("[SLAT] New spectator " + a.GetDisplayName())
	a.AddSpell(CommonProperties.SpectatorCooldownAbility)
	
	IsSexist = a.GetFactionRank(CommonProperties.IsSexistFaction) >= 0
	ActorFanciesPlayer = COMMON_Utility.IsAIntoB(a, player)
	; Variate delta so that spectator caused load spreads more evenly
	RegisterForSingleUpdate(updateDelta + Utility.RandomFloat(-0.5,0.5))
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
	
	arousal = a.GetFactionRank(Integrations.SLA.slaArousal)
	
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
		; Spread update for even load
		RegisterForSingleUpdate(updateDelta + Utility.RandomFloat(-0.5,0.5))
	endIf
endEvent


bool function UpdateVision()
	float distance = player.GetDistance(a)
	
	if(distance <= closeReachDistance)
		reasonForFocus = UpdateCloseReach() || reasonForFocus
	endIf
	
	if(distance <= midReachDistance)
		reasonForFocus = UpdateMidReach() || reasonForFocus
	endIf
	
	if(reasonForFocus)
		a.SetLookAt(player, true)
	endIf
	
	bool reasonForFocus = false
	if(distance <= longReachDistance)
		reasonForFocus = UpdateLongReach() || reasonForFocus
	endIf
	
	if(distance <= canTouchDistance)
		reasonForFocus = UpdateCanTouchReach() || reasonForFocus
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
	
	return playerIsHavingSex || (playerIsNaked && ActorFanciesPlayer)
endFunction

;return if there is reason for attention
bool Function UpdateMidReach()
	bool playerIsTeasing = CommonProperties.PlayerIsTeasing

	if(!PlayerWasTeasing && playerIsTeasing)
		Debug.Notification(""+ a.GetDisplayName() + " sees player is teasing.")
		PlayerWasTeasing = true
	endIf
	
	; Whistle?
	; Fancy + visible nipple piercings
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

bool Function UpdateCanTouchReach()
	
	; Can slap?
	if(Integrations.STA)
		; IsSexist == Slap
		if(IsSexist)
			float chance = Utility.RandomFloat(0, 0.3)
			if(chance <= 0.3)
				Debug.Trace("[SLAT] sending spanker " + a.GetDisplayName())
				Int ModSpankEvent = ModEvent.Create("STA_DoNpcSpankSpecific")
				ModEvent.PushFloat(ModSpankEvent, 15) ; Timeout
				ModEvent.PushForm(ModSpankEvent, a as Form)
				ModEvent.PushBool(ModSpankEvent, true) ; allow furniture spank
				ModEvent.PushFloat(ModSpankEvent, -1.0)
				ModEvent.Send(ModSpankEvent)
			endIf
		endIf
	endIf
	; Small chance to rape if ActorFanciesPlayer that raises with arousement
	; Comment cum? PlayerHadCum
	; Comment masturbation
	; Comment sex
	; If arousal is high && male jerk at player? Needs corrupt world?


endFunction
	