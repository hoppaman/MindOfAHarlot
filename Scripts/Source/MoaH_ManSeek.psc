Scriptname MoaH_ManSeek extends MoaH_QuestBase

string Property EventNameToSend = "" Auto

function StartSeek(string eventToFire)
	if(!IsRunning())
		EventNameToSend = eventToFire
		Start()
	endIf
endFunction