Scriptname MoaH_ThoughtProviderFemale extends MoaH_ThoughtProviderBase

string[] ThoughtsStage1ArousalA
int[] ThoughtsStage1ArousalAExpressions
string[] ThoughtsStage1ArousalB
int[] ThoughtsStage1ArousalBExpressions
string[] ThoughtsStage1ArousalC
int[] ThoughtsStage1ArousalCExpressions

string[] ThoughtsStage2ArousalA
int[] ThoughtsStage2ArousalAExpressions
string[] ThoughtsStage2ArousalB
int[] ThoughtsStage2ArousalBExpressions
string[] ThoughtsStage2ArousalC
int[] ThoughtsStage2ArousalCExpressions

string[] ThoughtsStage3ArousalA
int[] ThoughtsStage3ArousalAExpressions
string[] ThoughtsStage3ArousalB
int[] ThoughtsStage3ArousalBExpressions
string[] ThoughtsStage3ArousalC
int[] ThoughtsStage3ArousalCExpressions

; Text replacement
; <RandomVisibleNPCMale>
; <OldSexPartnerMale>

; Expressions TODO

event OnInit()
	; Themes insecure, stage1
	; Theme stage1
	; This is kind of nice
	; I kind of like this
	
	; Theme arousal a: Feeling nice		
	ThoughtsStage1ArousalA = new string[5]
	ThoughtsStage1ArousalAExpressions = new int[5]
	ThoughtsStage1ArousalA[0] = "It feels nice to touch myself."
	ThoughtsStage1ArousalA[1] = "Wonder if <RandomVisibleNPCMale> would like to have me."
	ThoughtsStage1ArousalA[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage1ArousalA[3] = "My breasts are all tingly."
	ThoughtsStage1ArousalA[4] = "It feels so nice! Can't wait what happens."
	; Theme arousal b: What is this feeling?
	ThoughtsStage1ArousalB = new string[6]
	ThoughtsStage1ArousalBExpressions = new int[6]
	ThoughtsStage1ArousalB[0] = "It feels so nice to touch myself."
	ThoughtsStage1ArousalB[1] = "Wonder if <RandomVisibleNPCMale> would like to have me."
	ThoughtsStage1ArousalB[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage1ArousalB[3] = "Mmm, my breasts are all tingly."
	ThoughtsStage1ArousalB[4] = "My body is all tingly."
	ThoughtsStage1ArousalB[5] = "I feel so so excited. I could take on the world."
	; Theme arousal c: I need to feel this craving somehow
	ThoughtsStage1ArousalC = new string[6]
	ThoughtsStage1ArousalCExpressions = new int[6]
	ThoughtsStage1ArousalC[0] = "I feel moist. I should do something about it."
	ThoughtsStage1ArousalC[1] = "Wonder if <RandomVisibleNPCMale> would like to please me."
	ThoughtsStage1ArousalC[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage1ArousalC[3] = "Mmm, my breasts are sensitive."
	ThoughtsStage1ArousalC[4] = "My body is all excited."
	ThoughtsStage1ArousalC[5] = "I am so horny this isn't normal anymore!"
	
	; Themes insecure, stage2
	; Theme stage1
	; This is kind of nice
	; I kind of like this
	
	; Theme arousal a: Feeling nice		
	ThoughtsStage2ArousalA = new string[5]
	ThoughtsStage2ArousalAExpressions = new int[5]
	ThoughtsStage2ArousalA[0] = "It feels nice to touch myself."
	ThoughtsStage2ArousalA[1] = "Wonder if <RandomVisibleNPCMale> would like to have me."
	ThoughtsStage2ArousalA[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage2ArousalA[3] = "My breasts are all tingly."
	ThoughtsStage2ArousalA[4] = "It feels so nice! Can't wait what happens."
	; Theme arousal b: What is this feeling?
	ThoughtsStage2ArousalB = new string[8]
	ThoughtsStage2ArousalBExpressions = new int[8]
	ThoughtsStage2ArousalB[0] = "It feels so nice to touch myself. I should do it more often."
	ThoughtsStage2ArousalB[1] = "Wonder if <RandomVisibleNPCMale> would like to have me."
	ThoughtsStage2ArousalB[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage2ArousalB[3] = "Mmm, my breasts are all tingly."
	ThoughtsStage2ArousalB[4] = "My body is all tingly."
	ThoughtsStage2ArousalB[5] = "Are my breasts good enough?"
	ThoughtsStage2ArousalB[6] = "Mmm, having cock is a nice thought."
	ThoughtsStage2ArousalB[7] = "mmm, how I get this itch off?"
	; Theme arousal c: I need to feel this craving somehow
	ThoughtsStage2ArousalC = new string[5]
	ThoughtsStage2ArousalBExpressions = new int[5]
	ThoughtsStage2ArousalC[0] = "I feel moist. I should do something about it."
	ThoughtsStage2ArousalC[1] = "Wonder if <RandomVisibleNPCMale> would like to please me."
	ThoughtsStage2ArousalC[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage2ArousalC[3] = "Mmm, my breasts are sensitive."
	ThoughtsStage2ArousalC[4] = "My body is all excited."
	
	; Themes insecure, stage3
	; Theme stage2
	; Need to experience more
	; Curious: What if I fuck with x?
	; Theme arousal a: Feeling nice
	ThoughtsStage3ArousalA = new string[6]
	ThoughtsStage3ArousalAExpressions = new int[6]
	ThoughtsStage3ArousalA[0] = "It feels nice to touch myself."
	ThoughtsStage3ArousalA[1] = "Wonder if <RandomVisibleNPCMale> would like to have me."
	ThoughtsStage3ArousalA[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage3ArousalA[3] = "My breasts are all tingly."
	ThoughtsStage3ArousalA[4] = "It feels so nice! Can't wait what happens."
	ThoughtsStage3ArousalA[5] = "I am being so wet its not nice to walk."
	; Theme arousal b: Feeling hornier
	ThoughtsStage3ArousalB = new string[7]
	ThoughtsStage3ArousalBExpressions = new int[7]
	ThoughtsStage3ArousalB[0] = "It feels so nice to touch myself. I should do it more often."
	ThoughtsStage3ArousalB[1] = "Wonder if <RandomVisibleNPCMale> would like to have me."
	ThoughtsStage3ArousalB[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage3ArousalB[3] = "Mmm, my breasts are all tingly."
	ThoughtsStage3ArousalB[4] = "My body is all tingly."
	ThoughtsStage3ArousalB[5] = "Are my breasts good enough?"
	ThoughtsStage3ArousalB[6] = "Mmm, my crotch is all wet."
	; Theme arousal c: Looking actively for sex partner
	ThoughtsStage3ArousalC = new string[7]
	ThoughtsStage3ArousalBExpressions = new int[7]
	ThoughtsStage3ArousalC[0] = "I feel moist. I should do something about it."
	ThoughtsStage3ArousalC[1] = "Wonder if <RandomVisibleNPCMale> would like to please me."
	ThoughtsStage3ArousalC[2] = "Am I pretty enough that they notice me?"
	ThoughtsStage3ArousalC[3] = "Mmm, my breasts are so sensitive."
	ThoughtsStage3ArousalC[4] = "Please I need to have have it now."
	ThoughtsStage3ArousalC[5] = "Do they want me?"
	ThoughtsStage3ArousalC[6] = "Where are all the horny men?"
endEvent

bool function HasThoughts()
	return true
endFunction

string function GetThought()
	Actor player = Game.GetPlayer()
	int addictionStage = MUtility.GetAddictionStage(player)
	int arousalStage = MUtility.GetArousalStage(player)
	string[] arousalThoughts = None
	if(addictionStage == 3) ; Enjoying / not wanting to let go
		if(arousalStage == 3) ; 'C'
			arousalThoughts = ThoughtsStage3ArousalC
		elseIf(arousalStage == 2) ; 'B'
			arousalThoughts = ThoughtsStage3ArousalB
		else ; 'A'
			arousalThoughts = ThoughtsStage3ArousalA
		endIf
	elseif(addictionStage == 2) ; Almost there / curious
		if(arousalStage == 3) ; 'C'
			arousalThoughts = ThoughtsStage2ArousalC
		elseif(arousalStage == 2) ; 'B'
			arousalThoughts = ThoughtsStage2ArousalB
		else ; 'A'
			arousalThoughts = ThoughtsStage2ArousalA
		endif
	else ; Barely there / pondering
		if(arousalStage == 3) ; 'C'
			arousalThoughts = ThoughtsStage1ArousalC
		elseIf(arousalStage == 2) ; 'B'
			arousalThoughts = ThoughtsStage1ArousalB
		else ; 'A'
			arousalThoughts = ThoughtsStage1ArousalA
		endif
	endif
	string thought = MUtility.GetRandomString(arousalThoughts)
	return thought
endFunction