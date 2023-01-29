Scriptname SLAT_CU_Heels   

Function Notice(Actor akSpeaker, int mod) global
	if (mod > 0)
		Debug.Notification(akSpeaker.GetName() + " gaze visits on your feet and smiles.")
	elseif (mod < 0)
		Debug.Notification(akSpeaker.GetName() + " pouts at you.")
	else
		Debug.Notification(akSpeaker.GetName() + " gaze visits on your feet.")
	endIf
EndFunction