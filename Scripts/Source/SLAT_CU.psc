Scriptname SLAT_CU   

Function Notice(Actor akSpeaker, int mod) global
	if(mod > 0)
		; Positive
		Debug.Notification(akSpeaker.GetName() + " smiles at you.")
	elseif(mod < 0)
		; Negative
		Debug.Notification(akSpeaker.GetName() + "  pouts at you.")
	else
		; Neutral
		Debug.Notification(akSpeaker.GetName() + " raises an eyebrow.")
	endIF
endFunction