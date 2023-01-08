Scriptname MoaH_MorphUtility Hidden

function MorphActor(Actor akActor, string morphFile, float mod = 1.0) global
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
	NiOverride.UpdateModelWeight(akActor)
endFunction