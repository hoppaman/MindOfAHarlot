Scriptname COMMON_MorphUtility Hidden



function MorphActor(Actor akActor, string morphFile, float mod = 1.0) global
	Debug.Trace("[MoaH] Morphing " + akActor.GetDisplayName() + " with file " + morphFile + " mod " + mod)
	Debug.Notification("[MoaH] Morphing " + akActor.GetDisplayName() + " with file " + morphFile + " mod " + mod)
	JSONUtil.Load(morphFile)
	string[] morphNames = NiOverride.GetMorphNames(akActor)
	int index = 0
	while index < morphNames.Length
		string morphName = morphNames[index]
		; Racemenu format
		string path = ".morphs."+morphName+".value"
		if(JSONUtil.CanResolvePath(morphFile, path))
			float morphValue = JSONUtil.GetPathFloatValue(morphFile, path)*mod
			;Debug.Trace("Setting morph " + morphName + " at " + morphValue)
			NiOverride.SetMorphValue(akActor, morphName, morphValue)
		endIf
		index += 1
	endWhile
endFunction

function ApplyMorph(Actor akTarget, Faction morphFaction, string morphFile, float amountToMorph) global
	float max = 127.0
	float min = 0.0
	if !akTarget.IsInFaction(morphFaction)
		akTarget.AddToFaction(morphFaction)
	endIf
	
	float currentRank = akTarget.GetFactionRank(morphFaction) as float
	
	float nextRank = currentRank + amountToMorph
	float correction = 0
	if(nextRank > max)
		;-x
		correction = max - nextRank
	elseif(nextRank < min)
		;x
		correction = min - nextRank 
	endIf
	float realAmount = nextRank + correction
	
	akTarget.SetFactionRank(morphFaction, realAmount as int)
	
	currentRank = akTarget.GetFactionRank(morphFaction)

	COMMON_MorphUtility.MorphActor(akTarget, morphFile, (currentRank as float) / max)
	
	; Finally tell Racemenu to update morphs
	NiOverride.UpdateModelWeight(akTarget)
endFunction