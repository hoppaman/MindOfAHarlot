Scriptname SLAT_QuestHandlerHedonist extends Quest  

ReferenceAlias[] Property Hedonists Auto

bool Function SetHedonist(Actor hedonist)
	bool wasSet = false
	int index = 0
	While index < Hedonists.Length
		ReferenceAlias ra = Hedonists[index]
		if(ra)
			if(!ra.GetActorRef())
				ra.ForceRefTo(hedonist)
				wasSet = true
			endIf
		endIf
		index += 1
	endWhile
	return wasSet
endFunction