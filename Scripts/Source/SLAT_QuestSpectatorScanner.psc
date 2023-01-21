Scriptname SLAT_QuestSpectatorScanner extends Quest  

ReferenceAlias Property Spectator01 auto
ReferenceAlias Property Spectator02 auto
ReferenceAlias Property Spectator03 auto
ReferenceAlias Property Spectator04 auto
ReferenceAlias Property Spectator05 auto
ReferenceAlias Property Spectator06 auto
ReferenceAlias Property Spectator07 auto
ReferenceAlias Property Spectator08 auto
ReferenceAlias Property Spectator09 auto
ReferenceAlias Property Spectator10 auto

; Buffer/cache
Actor[] Property PotentialSpectators auto hidden
int Property PotentialSpectatorCount auto hidden

event OnInit()
	PotentialSpectators = new Actor[10]
	PotentialSpectatorCount = 0
endEvent

bool Function HasSpectator()
	return PotentialSpectatorCount > 0
endFunction

Actor Function GetRandomSpectator()
	int index = Utility.RandomInt(0,PotentialSpectatorCount)
	return PotentialSpectators[index]
endFunction

int Function Scan()
	if(IsRunning())
		Debug.Trace("[SLAT] multiple scan attempts")
		return 0
	endIf
	
	; Quest seeks the spectators
	Start()
	
	; Give moment for the scan
	Utility.Wait(0.3)
	
	Actor player = Game.GetPlayer()
	int foundIndex = 0
	
	Actor a1 = Spectator01.GetActorRef()
	if (a1)
		;if(COMMON_Utility.IsAIntoB(a1, player))
			PotentialSpectators[foundIndex] = a1
			foundIndex += 1
		;endIf
	endif
	
	if(Spectator02)
		Actor a2 = Spectator02.GetActorRef()
		if (a2)
			;if(COMMON_Utility.IsAIntoB(a2, player))
				PotentialSpectators[foundIndex] = a2
				foundIndex += 1
			;endIf
		endIf
	endIf
	
	if(Spectator03)
		Actor a3 = Spectator03.GetActorRef()
		if (a3)
			;if(COMMON_Utility.IsAIntoB(a3, player))
				PotentialSpectators[foundIndex] = a3
				foundIndex += 1
			;endIf
		endIf
	endIf
	
	if(Spectator04)
		Actor a4 = Spectator04.GetActorRef()
		if (a4)
			;if(COMMON_Utility.IsAIntoB(a4, player))
				PotentialSpectators[foundIndex] = a4
				foundIndex += 1
			;endIf
		endIf
	endIf
	
	if(Spectator05)
		Actor a5 = Spectator05.GetActorRef()
		if (a5)
			;if(COMMON_Utility.IsAIntoB(a5, player))
				PotentialSpectators[foundIndex] = a5
				foundIndex += 1
			;endIf
		endIf
	endIf
	
	if(Spectator06)
		Actor a6 = Spectator06.GetActorRef()
		if (a6)
			;if(COMMON_Utility.IsAIntoB(a6, player))
				PotentialSpectators[foundIndex] = a6
				foundIndex += 1
			;endIf
		endIf
	endIf
	
	if(Spectator07)
		Actor a7 = Spectator07.GetActorRef()
		if (a7)
			;if(COMMON_Utility.IsAIntoB(a7, player))
				PotentialSpectators[foundIndex] = a7
				foundIndex += 1
			;endIf
		endIf
	endIf
	
	if(Spectator08)
		Actor a8 = Spectator08.GetActorRef()
		if (a8)
			;if(COMMON_Utility.IsAIntoB(a8, player))
				PotentialSpectators[foundIndex] = a8
				foundIndex += 1
			;endIf
		endIf
	endIf

	if(Spectator09)
		Actor a9 = Spectator09.GetActorRef()
		if (a9)
			;if(COMMON_Utility.IsAIntoB(a9, player))
				PotentialSpectators[foundIndex] = a9
				foundIndex += 1
			;endIf
		endIf
	endIf
	
	if(Spectator10)
		Actor a10 = Spectator10.GetActorRef()
		if (a10)
			;if(COMMON_Utility.IsAIntoB(a10, player))
				PotentialSpectators[foundIndex] = a10
				foundIndex += 1
			;endIf
		endIf
	endIf
	PotentialSpectatorCount = foundIndex
	; Stop and ready scanner for reuse
	Stop()
	Reset()
	return foundIndex
endFunction