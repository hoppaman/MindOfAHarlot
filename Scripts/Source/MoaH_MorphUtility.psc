Scriptname MoaH_MorphUtility Hidden

function MorphActor(Actor akActor, string morphFile, float mod = 1.0) global
	JSONUtil.Load(morphFile)
	string[] morphNames = NiOverride.GetMorphNames(akActor)
	int index = 0
	while index < morphNames.Length
		string morphName = morphNames[index]
		; Racemenu format
		string path = ".morphs."+morphName+".value"
		if(JSONUtil.IsPathNumber(morphFile, path))
			float morphValue = JSONUtil.GetPathFloatValue(morphFile, path)
			NiOverride.SetMorphValue(akActor, morphName, morphValue)
		endIf
		;if(JSONUtil.HasFloatValue(morphFile, morphName))
		;	NiOverride.SetMorphValue(akActor, morphName, JSONUtil.GetFloatValue(morphFile, morphName) * mod)
		;endIf
	endWhile
endFunction