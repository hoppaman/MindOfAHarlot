Scriptname SLAT_CU_NipplePiercings  

Function Notice(Actor akSpeaker, int mod) global
	if (mod > 0)
		; Positive
		Debug.Notification(akSpeaker.GetName() + " gaze visits your chest and smiles.")
	elseif(mod < 0)
		; Negative
		Debug.Notification(akSpeaker.GetName() + " pouts at you.")
	else
		; Neutral
		Debug.Notification(akSpeaker.GetName() + " gaze visits your chest.")
	endIf
EndFunction