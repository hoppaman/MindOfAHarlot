Scriptname SLAT_QuestThoughtsScanner extends Quest  

ReferenceAlias Property CloseByMale Auto
ReferenceAlias Property CloseByFemale Auto
ReferenceAlias Property CloseByGuard Auto
ReferenceAlias Property CloseByRich Auto

int Function Scan()
	if(IsRunning())
		; Should not occur
		Debug.Trace("[SLAT] ERROR: multiple scan attemps")
		return 0
	endIf
	
	Start()
	
	Utility.Wait(0.3)
	int foundCount = 0
	if(CloseByFemale && CloseByFemale.GetActorRef())
		foundCount += 1
	endIf
	
	if(CloseByMale && CloseByMale.GetActorRef())
		foundCount += 1
	endIf
	
	if(CloseByGuard && CloseByGuard.GetActorRef())
		foundCount += 1
	endIf
	
	if(CloseByRich && CloseByRich.GetActorRef())
		foundCount += 1
	endIf
	
	Stop()
	Reset()
	
	return foundCount
endFunction