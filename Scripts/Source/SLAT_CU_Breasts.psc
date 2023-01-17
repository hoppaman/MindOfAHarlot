Scriptname SLAT_CU_Breasts 

Function Notice(Actor akSpeaker, bool positive) global
	if (positive)
		Debug.Notification(akSpeaker.GetName() + " gaze visits on your chest and smiles.")
	else
		Debug.Notification(akSpeaker.GetName() + " pouts at you.")
	endIf
EndFunction