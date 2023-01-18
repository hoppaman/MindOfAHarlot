Scriptname SLAT_CU_Ass   

Function Notice(Actor akSpeaker, int mod) global
	if (mod > 0)
		Debug.Notification(akSpeaker.GetName() + " gaze visits on your ass and smiles.")
	elseif (mod < 0)
		Debug.Notification(akSpeaker.GetName() + " pouts at you.")
	else
		Debug.Notification(akSpeaker.GetName() + " gaze visits on your ass.")
	endIf
endFunction