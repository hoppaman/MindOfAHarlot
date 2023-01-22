Scriptname SLAT_QuestSpectatorManager extends Quest  

SLAT_QuestCommonProperties Property CommonProperties auto

SLAT_QuestSpectatorScanner Property scanner auto

Topic Property Comments auto

ReferenceAlias Property Watcher01 auto
ReferenceAlias Property Watcher02 auto
ReferenceAlias Property Watcher03 auto
ReferenceAlias Property Watcher04 auto
ReferenceAlias Property Watcher05 auto
ReferenceAlias Property Watcher06 auto

Actor Property Player auto

ReferenceAlias[] Watchers

;Actor[] Property CurrentSpectators auto hidden

event OnInit()
	Watchers = new ReferenceAlias[6]
	Watchers[0] = Watcher01
	Watchers[1] = Watcher02
	Watchers[2] = Watcher03
	Watchers[3] = Watcher04
	Watchers[4] = Watcher05
	Watchers[5] = Watcher06
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
						ReferenceAlias watcher = Watchers[indexY]
						
						if(!watcher.GetReference() && !IsIn(Watchers, spect))
							Debug.Notification("[SLAT] Observer " + indexY + " is now " + spect.GetDisplayName())
							watcher.ForceRefTo(spect)
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

bool Function IsIn(ReferenceAlias[] list, Actor act)
	bool isIn = false
	int index = 0
	While index < list.Length && !isIn
		ReferenceAlias ra = list[index]
		if(ra.GetActorRef() == act)
			isIn = true
		endIf
		index += 1
	endWhile
	return isIn
endFunction