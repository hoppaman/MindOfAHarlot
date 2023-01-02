scriptname MoaH_Utility HIDDEN

bool Function Masturbate(Actor performer, Bool allowBed = false, ObjectReference centerOn = none) Global
	Debug.Trace("Masturbate actor: " + (performer As String))
	sslBaseAnimation[] animsSearch
	sslBaseAnimation[] anims
	Actor[] aActors = New Actor[1]
	aActors[0] = performer

	SexLabFramework SexLab = SexLabUtil.GetAPI()

	If (SexLab.GetGender(performer) == 0)
		animsSearch = SexLab.GetAnimationsByType(1, Males = 1)
	Else
		animsSearch = SexLab.GetAnimationsByType(1, Females = 1)
	EndIf

	If (!(animsSearch))
		Debug.Trace("Masturbate did not find any animations for masturbation.")
	Else
		Debug.Trace("Masturbate found " + (animsSearch.Length As String) + " animations.")
		anims = animsSearch
	EndIf

	If (!SexLab.IsValidActor(performer))
		Debug.Trace("Masturbate got an invalid actor: " + (performer As String))
		Return false
	EndIf

	If (SexLab.StartSex(aActors, anims, none, centerOn, allowBed) >= 0)
		Return true
	Else
		Return false
	EndIf
EndFunction