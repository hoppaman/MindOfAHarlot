scriptname MoaH_QuestHarlotSLATTPFemaleMemory extends SLAT_ThoughtProviderBase

; Sex partners
string[] SexPartnersLow ; Lower addiction
string[] SexPartnersHigh ; Higher addiction

Actor[] LastSexPartners ; tracked partners
float[] LastSexPartnersGameTime ; Time when memory was added. This is used for memory decay
float[] LastSexPartnersLastGameTime ; When used last

int ThoughtsCount = 0

event OnInit()
	Actor player = Game.GetPlayer()
	; Last sex partner
	LastSexPartners = new Actor[5]
	LastSexPartnersGameTime = new float[5]
	LastSexPartnersLastGameTime = new float[5]
	; Sanguine
	
	; Bi curiosity
	
	; SexLab most common sex partners
	;CommonProperties.SexLab.LastSexPartner(player)
	RegisterForUpdate(10)
endEvent

event OnUpdate()
	; Update dynamic things like last sex partner here
	; Also decaying of memories should be done here
	Actor player = Game.GetPlayer()
	; Track sex to get actor and type of sex
	
endEvent

bool function HasThought(Actor closeByCrush)
	return ThoughtsCount > 0
endFunction

; Relating to quest or sex partner..
int function GetProviderPriority(Actor closeByCrush)
	return 80
endFunction

string function GetThought(Actor closeByCrush)
	return None
endFunction

