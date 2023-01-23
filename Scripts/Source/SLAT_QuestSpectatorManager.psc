Scriptname SLAT_QuestSpectatorManager extends Quest  

SLAT_QuestCommonProperties Property CommonProperties auto
SLAT_QuestSpectatorScanner Property scanner auto

Topic Property Comments auto

Actor Property Player auto

SLAT_RefSpectator[] Property Watchers auto

;Actor[] Property CurrentSpectators auto hidden

event OnInit()
	RegisterForUpdate(10.0)
endEvent

event OnUpdate()

	if(!scanner.IsRunning())
		; This may take a moment
		
		int foundCount = scanner.Scan()
		Actor[] potSpecs = scanner.PotentialSpectators
		Debug.Notification("Player is teasing: " + CommonProperties.PlayerIsTeasing + " specs " + foundCount)
		if (foundCount > 0)
			int index = 0
			While index < foundCount
				Actor spect = potSpecs[index]
				;Debug.Notification("We have spectator " + spect.GetDisplayName())
				;spect.Say(Comments)
				if(COMMON_Utility.DoesASeeB(spect, player))
					int indexY = 0
					bool isSet = false
				
					While indexY < Watchers.Length && !isSet
						SLAT_RefSpectator watcher = Watchers[indexY]
						
						if(!watcher.GetReference() && !IsIn(Watchers, spect))
							;Debug.Notification("[SLAT] Observer " + indexY + " is now " + spect.GetDisplayName())
							watcher.ForceRefTo(spect)
							watcher.BootUp()
							
							isSet = true
						endIf
						indexY += 1
					endWhile
				endIf
				index += 1
			endWhile
		endIf
	endIf
endEvent

bool Function IsIn(SLAT_RefSpectator[] list, Actor act)
	bool isIn = false
	int index = 0
	While index < list.Length && !isIn
		SLAT_RefSpectator ra = list[index]
		if(ra.GetActorRef() == act)
			isIn = true
		endIf
		index += 1
	endWhile
	return isIn
endFunction