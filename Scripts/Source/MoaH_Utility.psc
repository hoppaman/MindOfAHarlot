scriptname MoaH_Utility extends Quest

MoaH_CommonProperties Property CommonProperties Auto

Function DisableControls()
	Game.DisablePlayerControls(abMovement = True, abFighting = True, abSneaking = False, abMenu = True, abActivate = True)
EndFunction

Function UpdateControls()
	Debug.Trace("UpdateControls()")
	; Centralized control management function.
	bool movement = true
	bool fighting = true
	bool sneaking = true
	bool menu = true
	bool activate = true
	int cameraState = Game.GetCameraState()
	Game.DisablePlayerControls(abMovement = !movement, abFighting = !fighting, abSneaking = !sneaking, abMenu = !menu, abActivate = !activate)	
	Game.EnablePlayerControls(abMovement = movement, abFighting = fighting, abSneaking = sneaking, abMenu = menu, abActivate = activate)	
EndFunction

bool Function Masturbate(Actor performer, Bool allowBed = false, ObjectReference centerOn = none)
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

bool Function IsValidActor(actor akActor)
	return (akActor.Is3DLoaded() && !akActor.IsDead() && !akActor.IsDisabled() && akActor.GetCurrentScene() == none)
EndFunction

bool Function IsAnimating(actor akActor)
	if (akActor.GetSitState() != 0) || akActor.IsOnMount()
		return True
	endif
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	Faction IsAnimatingFaction = CommonProperties.IsAnimatingFaction
	return (akActor.IsInFaction(IsAnimatingFaction) || akActor.IsInFaction(Sexlab.AnimatingFaction))
EndFunction

Function SetAnimating(actor akActor, bool isAnimating=true)
	Faction IsAnimatingFaction = CommonProperties.IsAnimatingFaction
	if isAnimating
		akActor.AddToFaction(IsAnimatingFaction)
		akActor.SetFactionRank(IsAnimatingFaction, 1)
	Else
		akActor.RemoveFromFaction(IsAnimatingFaction)
	EndIf
EndFunction

bool[] Function StartThirdPersonAnimation(actor akActor, Idle animation)
	Debug.Trace("StartThirdPersonAnimation("+akActor.GetDisplayName()+","+animation+")")
	bool[] ret = new bool[2]
	if IsAnimating(akActor)
		Debug.Trace("Actor already in animation faction.")
		return ret
	EndIf
	
	if !IsValidActor(akActor)
		Debug.Trace("Actor is not loaded (Or is otherwise invalid). Aborting.")
		return ret
	EndIf
	
	if (akActor.IsWeaponDrawn())
		akActor.SheatheWeapon()
		; Wait for users with flourish sheathe animations.
		int timeout=0
		while akActor.IsWeaponDrawn() && timeout <= 35 ;  Wait 3.5 seconds at most before giving up and proceeding.
			Utility.Wait(0.1)
			timeout += 1
		EndWhile
		ret[1] = true
	EndIf
	
	if akActor == Game.GetPlayer()
		; Manipulate camera
		int cameraOld = Game.GetCameraState()
		if cameraOld == 10 || akActor.IsOnMount(); 10 On a horse
			akActor.Dismount()
			game.ForceThirdPerson()
			int timeout = 0
			while akActor.IsOnMount() && timeout <= 30; Wait for dismount to complete
				Utility.Wait(0.1)
				timeout += 1
			EndWhile
		ElseIf cameraOld == 11; Bleeding out.
			Debug.Trace("Actor is bleeding out. Hmm.")
			return ret
		ElseIf cameraOld == 12 ; Dragon?
			Debug.Trace("Actor is dragon? Not sure what happened here.")
			return ret
		ElseIf cameraOld == 8 || cameraOld == 9 || cameraOld ==  7 ;;; 8 / 9 are third person. 7 is tween menu.
		;
		Else
			ret[0] = true
			game.ForceThirdPerson()
		EndIf
				
		; Freeze player controls
		DisableControls()
	Else
		akActor.SetDontMove(true)
	EndIf
	SetAnimating(akActor, true)
	akActor.PlayIdle(animation)
	return ret
EndFunction

Function PlayThirdPersonAnimation(actor akActor, Idle animation, int duration)
	Debug.Trace("PlayThirdPersonAnimation("+akActor.GetLeveledActorBase().GetName()+","+animation+","+duration+")")
	if IsAnimating(akActor)
		Debug.Trace("Actor already in animating faction.")
		return
	EndIf
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	if SexLab.ValidateActor(akActor) < 0 || akActor.IsSwimming() || akActor.IsOnMount() || akActor.GetCurrentScene() != none || akActor.GetSitState() != 0
		Debug.Trace("Not playing third person animation: Actor is already in a blocking animation.")
		return
	EndIf
	bool[] cameraState=StartThirdPersonAnimation(akActor, animation)
	Debug.Trace("Playing animation for "+duration+" seconds.")
	Utility.Wait(duration)
	EndThirdPersonAnimation(akActor, cameraState)
EndFunction

Function EndThirdPersonAnimation(actor akActor, bool[] cameraState)
	Debug.Trace("EndThirdPersonAnimation("+akActor.GetDisplayName()+","+cameraState+")")
	SetAnimating(akActor, false)
	if (!akActor.Is3DLoaded() ||  akActor.IsDead() || akActor.IsDisabled())
		Debug.Trace("Actor is not loaded (Or is otherwise invalid). Aborting.")
		return
	EndIf
	; Reset idle 
	Debug.SendAnimationEvent(akActor, "IdleForceDefaultState")
	if akActor == Game.GetPlayer()
		UpdateControls()
		if cameraState[0]
			game.ForceFirstPerson()		
		EndIf
		if cameraState[1]
			;akActor.SheatheWeapon()
			;akActor.DrawWeapon()
		EndIf
	Else
		akActor.SetDontMove(false)
	EndIf
EndFunction