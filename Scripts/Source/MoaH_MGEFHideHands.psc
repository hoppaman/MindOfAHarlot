Scriptname MoaH_MGEFHideHands extends activemagiceffect  

string HIDE_HANDS_KEY = "HIDE_HANDS_KEY"

string NINODE_RIGHT_HAND = "NPC R Hand [RHnd]"
string NINODE_LEFT_HAND = "NPC L Hand [LHnd]"

string NINODE_RIGHT_FOOT = "NPC R Foot [Rft ]"
string NINODE_LEFT_FOOT = "NPC L Foot [Lft ]"

event OnEffectStart(Actor akTarget, Actor akCaster)
	SetNodeScale(akTarget, NINODE_LEFT_HAND, 0.0)
	SetNodeScale(akTarget, NINODE_RIGHT_HAND, 0.0)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	SetNodeScale(akTarget, NINODE_LEFT_HAND, 1.0)
	SetNodeScale(akTarget, NINODE_RIGHT_HAND, 1.0)
endEvent

Function SetNodeScale(Actor akActor, string nodeName, float value)
	bool isFemale = false
	if(akActor.GetActorBase().GetSex() == 1)
		isFemale = true
	endif

	If value != 1.0
		NiOverride.AddNodeTransformScale(akActor, false, isFemale, nodeName, HIDE_HANDS_KEY, value)
		NiOverride.AddNodeTransformScale(akActor, true, isFemale, nodeName, HIDE_HANDS_KEY, value)
	Else
		NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, HIDE_HANDS_KEY)
		NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, HIDE_HANDS_KEY)
	Endif
	NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
	NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
EndFunction

float Function GetNodeScale(Actor akActor, bool isFemale, string nodeName)
	return NiOverride.GetNodeTransformScale(akActor, false, isFemale, nodeName, HIDE_HANDS_KEY)
EndFunction

Function RemoveNodeTransforms(Actor akActor, bool isFemale, string nodeName)
	NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, HIDE_HANDS_KEY)
	NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, HIDE_HANDS_KEY)
EndFunction