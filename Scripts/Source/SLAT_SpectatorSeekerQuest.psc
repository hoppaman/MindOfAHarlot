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

	; Basically same feature as Misc>"hello"
	;Debug.Trace("[SLAT] update")
	;ObjectReference ref = Game.GetCurrentCrosshairRef()
	;Actor player = Game.GetPlayer()
	
	;if ref && ref as Actor
	;	Actor a = ref as Actor
	;	Debug.Trace("[SLAT] got crosshair")
	;	if(IsAIntoB(a, player))
	;		Debug.Trace("[SLAT] crosshair notice")
	;		ANoticesB(a, player)
	;	endIf
	;endIf

	seekAroundEveryNthUpdateCounter += 1
	if(seekAroundEveryNthUpdateCounter >= seekAroundEveryNthUpdate)
		Actor[] asEmpty
		float[] fsEmpty
		spectators = asEmpty
		spectatorTimeAdded = fsEmpty
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
			Debug.Trace("[SLAT] Male is into female")
			isInto = true
		elseif(aSex == 1 && aSexuality > 35)
			; Lesbian/bi-curious female
			Debug.Trace("[SLAT] Female is into female")
			isInto = true
		endIf
	elseif(bSex == 0)
		; b is male
		if(aSex == 1 && aSexuality < 65)
			; Straight female
			Debug.Trace("[SLAT] Female is into male")
			isInto = true
		elseif(aSex == 0 && aSexuality > 35)
			; Gay/gayish male
			Debug.Trace("[SLAT] male is into male")
			isInto = true
		endIf
	endIf
	return isInto
endFunction

function SeekAroundSpectators()
	Actor player = Game.GetPlayer()
	Actor[] actors = COMMON_Utility.FindAdultActorsNear(player, 6000)
	Debug.Trace("[SLAT] seek " + actors.Length)
	int index = 0
	While index < actors.Length
		Actor potSpect = actors[index]
		bool validSpect = IsAIntoB(potSpect, player)

		if(validSpect)
			Debug.Trace("[SLAT] found spectator")
			PapyrusUtil.PushActor(actors, potSpect)
			PapyrusUtil.PushFloat(spectatorTimeAdded, Utility.GetCurrentRealTime())
			ANoticesB(potSpect, player)
		endIf			
	endWhile
endFunction

function ANoticesB(Actor a, Actor b)
	Debug.Trace("[SLAT] a notice b")
	Debug.Notification("[SLAT] a notice b")
	a.Say(TestIamIntoYou)
endFunction