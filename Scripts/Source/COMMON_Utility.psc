scriptname COMMON_Utility Hidden

bool Function Masturbate(Actor performer, Bool allowBed = false, ObjectReference centerOn = none) global
	Debug.Trace("[MoaH] Masturbate actor: " + (performer As String))
	if(IsAnimating(performer))
		Debug.Trace("[MoaH] Could not start animation actor is already animating")
		return false
	endIf
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
		Debug.Trace("[MoaH] Masturbate did not find any animations for masturbation.")
	Else
		Debug.Trace("[MoaH] Masturbate found " + (animsSearch.Length As String) + " animations.")
		anims = animsSearch
	EndIf

	If (!SexLab.IsValidActor(performer))
		Debug.Trace("[MoaH] Masturbate got an invalid actor: " + (performer As String))
		Return false
	EndIf

	If (SexLab.StartSex(aActors, anims, none, centerOn, allowBed) >= 0)
		Return true
	Else
		Return false
	EndIf
EndFunction

bool Function IsValidActor(actor akActor) global
	return (akActor.Is3DLoaded() && !akActor.IsDead() && !akActor.IsDisabled() && akActor.GetCurrentScene() == none)
EndFunction

bool Function IsAnimating(actor akActor) global
	if (akActor.GetSitState() != 0) || akActor.IsOnMount()
		return True
	endif
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	
	return akActor.IsInFaction(Sexlab.AnimatingFaction)
EndFunction

Function DisableControls() global
	Game.DisablePlayerControls(abMovement = True, abFighting = True, abSneaking = False, abMenu = True, abActivate = True)
EndFunction


Function SetAnimating(actor akActor, bool isAnimating=true) global
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	if isAnimating
		akActor.AddToFaction(Sexlab.AnimatingFaction)
		akActor.SetFactionRank(Sexlab.AnimatingFaction, 1)
	Else
		akActor.RemoveFromFaction(Sexlab.AnimatingFaction)
	EndIf
EndFunction

bool[] Function StartThirdPersonAnimation(actor akActor, Idle animation) global
	Debug.Trace("[MoaH] StartThirdPersonAnimation("+akActor.GetDisplayName()+","+animation+")")
	bool[] ret = new bool[2]
	if IsAnimating(akActor)
		Debug.Trace("[MoaH] Actor already in animation faction.")
		return ret
	EndIf
	
	if !IsValidActor(akActor)
		Debug.Trace("[MoaH] Actor is not loaded (Or is otherwise invalid). Aborting.")
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
			Debug.Trace("[MoaH] Actor is bleeding out. Hmm.")
			return ret
		ElseIf cameraOld == 12 ; Dragon?
			Debug.Trace("[MoaH] Actor is dragon? Not sure what happened here.")
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
	akActor.SetAnimationVariableBool("bHumanoidFootIKDisable", true)
	Utility.Wait(0.2)
	SetAnimating(akActor, true)
	akActor.PlayIdle(animation)
	return ret
EndFunction

Function PlayThirdPersonAnimation(actor akActor, Idle animation, float duration) global
	Debug.Trace("[MoaH] PlayThirdPersonAnimation("+akActor.GetLeveledActorBase().GetName()+","+animation+","+duration+")")
	if IsAnimating(akActor)
		Debug.Trace("[MoaH] Actor already in animating faction.")
		return
	EndIf
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	if SexLab.ValidateActor(akActor) < 0 || akActor.IsSwimming() || akActor.IsOnMount() || akActor.GetCurrentScene() != none || akActor.GetSitState() != 0
		Debug.Trace("[MoaH] Not playing third person animation: Actor is already in a blocking animation.")
		return
	EndIf
	bool[] cameraState=StartThirdPersonAnimation(akActor, animation)
	Debug.Trace("[MoaH] Playing animation for "+duration+" seconds.")
	Utility.Wait(duration)
	EndThirdPersonAnimation(akActor, cameraState)
EndFunction

Function EndThirdPersonAnimation(actor akActor, bool[] cameraState) global
	Debug.Trace("[MoaH] EndThirdPersonAnimation("+akActor.GetDisplayName()+","+cameraState+")")
	SetAnimating(akActor, false)
	if (!akActor.Is3DLoaded() ||  akActor.IsDead() || akActor.IsDisabled())
		Debug.Trace("[MoaH] Actor is not loaded (Or is otherwise invalid). Aborting.")
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


Function UpdateControls() global
	Debug.Trace("[MoaH] UpdateControls()")
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

string function ReplaceString(string from, string toReplace, string replacingString) global
	string retString = from
	bool keepSeeking = true
	int ind = 0
	While keepSeeking
		ind = StringUtil.Find(from, toReplace)
		if ( ind == -1 )
			keepSeeking = false
		else
			string startString = StringUtil.Substring(from, 0, ind - 1)
			int endStart = ind + StringUtil.GetLength(toReplace) - 1
			string endString = StringUtil.Substring(from, endStart, StringUtil.GetLength(from) - endStart)
			retString = startString + replacingString + endString
		endIf
	endWhile
	return retString
endFunction

string function GetRandomString(string[] stringArray) global
	if(stringArray.Length > 0)
		int randomInt = Utility.RandomInt(0,stringArray.Length - 1)
		return stringArray[randomInt]
	endIf
	return None
endFunction

Actor[] function FindAdultActorsNear(Actor akTarget, float radius, int sex = -1) global
	SexLabFramework SexLab = SexLabUtil.GetAPI()
	; ActorTypeNPC
	Keyword actorTypeNPC = Game.GetFormFromFile(0x013794, "Skyrim.esm") as Keyword
	Actor[] actors = MiscUtil.ScanCellNPCs(akTarget, radius, actorTypeNPC)
	PapyrusUtil.RemoveActor(actors, akTarget) ; don't allow self
	
	int index = 0
	While index < actors.Length
		Actor randomNPC = (actors[index] as Actor)
		
		if( (sex == -1 || SexLab.GetGender(randomNPC) == sex) && !randomNPC.IsChild() && !randomNPC.IsDead())
			index + 1
		else
			PapyrusUtil.RemoveActor(actors, randomNPC)
		endIf
	endWhile
endFunction

function AddFactionRank(Actor akActor, Faction akFaction, int amount, int maxRank = 127) global
	int Score = akActor.GetFactionRank(akFaction)
	if(Score < maxRank)
		Score = Score + amount
		if(Score > maxRank)
			amount = amount - (Score - maxRank)
			Score = maxRank
		EndIf
		akActor.ModFactionRank(akFaction, amount)
	endIf
endFunction

function ReduceFactionRank(Actor akActor, Faction akFaction, int amount) global
	int Score = akActor.GetFactionRank(akFaction)
	
	if(Score > 0)
		Score = Score - amount
		if(Score < 0)
			amount = amount + Score
			Score = 0
		EndIf

		akActor.ModFactionRank(akFaction, -amount)
	endIf
endFunction