Scriptname SLAT_QuestSpectatorScanner extends Quest  

ReferenceAlias[] Property Spectators auto

ReferenceAlias Property Spectated auto

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
		Debug.Trace("[SLAT] ERROR: multiple scan attempts")
		return 0
	endIf
	
	; Quest seeks the spectators
	Start()
	
	; Give moment for the scan
	Utility.Wait(0.3)
	
	Actor player = Game.GetPlayer()
	int foundIndex = 0
	int seekIndex = 0
	While seekIndex < Spectators.Length
		ReferenceAlias ra = Spectators[seekIndex]
		
		if(ra)
			Actor act = ra.GetActorRef()
			if(act)
				
				PotentialSpectators[foundIndex] = act
				foundIndex += 1
			endIf
		endIf
		seekIndex += 1
	endWhile

	PotentialSpectatorCount = foundIndex
	; Stop and ready scanner for reuse
	Stop()
	Reset()
	return foundIndex
endFunction