;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname MoaH_DialogueFlirt_EndFragment Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor target = akSpeaker.GetDialogueTarget()
target.SetExpressionOverride(2,Utility.RandomInt(25,100))
Debug.Notification(target.GetDisplayName() + " smiles at you.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
