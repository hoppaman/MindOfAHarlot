Scriptname SLAT_SpectatorSeekerQuest extends Quest  

Topic Property TestIamIntoYou Auto

SexLabFramework SexLab

Actor[] spectators
float[] spectatorTimeAdded

int seekAroundEveryNthUpdateCounter = 0
int seekAroundEveryNthUpdate = 5
event OnInit()
	SexLab = SexLabUtil.GetAPI()
	RegisterForUpdate(5)
	; For testing
	Update()	
endEvent

event OnUpdate()
	Update()
endEvent

function Update()
	ObjectReference ref = Game.GetCurrentCrosshairRef()
	Actor player = Game.GetPlayer()
	
	if ref && ref as Actor
		Actor a = ref as Actor
		if(IsAIntoB(a, player))
			ANoticesB(a, player)
		endIf
	endIf

	seekAroundEveryNthUpdateCounter += 1
	if(seekAroundEveryNthUpdateCounter >= seekAroundEveryNthUpdate)
		spectators = None
		spectatorTimeAdded = None
		SeekAroundSpectators()
		seekAroundEveryNthUpdateCounter = 0
	endIf
endFunction

bool function IsAIntoB(Actor a, actor b)
	; Fem SexLab.GetSexuality() < 65 male > 35 female
	int aSex = SexLab.GetGender(a)
	int aSexuality = SexLab.GetSexuality(a)
	int bSex = SexLab.GetGender(b)
	bool isInto = false
	if(bSex == 1)
		; b is female
		if(aSex == 0 && aSexuality < 65)
			; Straight male
			isInto = true
		elseif(aSex == 1 && aSexuality > 35)
			; Lesbian/bi-curious female
			isInto = true
		endIf
	elseif(bSex == 0)
		; b is male
		if(aSex == 1 && aSexuality < 65)
			; Straight female
			isInto = true
		elseif(aSex == 0 && aSexuality > 35)
			; Gay/gayish male
			isInto = true
		endIf
	endIf
	return isInto
endFunction

function SeekAroundSpectators()
	Actor player = Game.GetPlayer()
	Actor[] actors = COMMON_Utility.FindAdultActorsNear(player, 6000)
	int index = 0
	While index < actors.Length
		Actor potSpect = actors[index]
		bool validSpect = IsAIntoB(potSpect, player)

		if(validSpect)
			PapyrusUtil.PushActor(actors, potSpect)
			PapyrusUtil.PushFloat(spectatorTimeAdded, Utility.GetCurrentRealTime())
		endIf			
	endWhile
endFunction

function ANoticesB(Actor a, Actor b)
	a.Say(TestIamIntoYou)
endFunction