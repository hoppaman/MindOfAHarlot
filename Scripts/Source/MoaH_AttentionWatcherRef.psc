Scriptname MoaH_AttentionWatcherRef extends ReferenceAlias

MoaH_CommonProperties property CommonProperties auto

Actor watcher = None
bool isWatching = false
event OnInit()
	Actor akTarget = Game.GetPlayer()
	watcher = GetActorReference()
	watcher.SetLookAt(akTarget, true)
	isWatching = true
	Debug.Notification("[MoaH] Attention " + watcher.GetDisplayName() + " is watching " + akTarget.GetDisplayName())
	int handle = ModEvent.Create(CommonProperties.AttentionLookAtEventName)
	ModEvent.PushForm(handle, watcher)
	ModEvent.PushForm(handle, akTarget)
	ModEvent.Send(handle)
	RegisterForSingleUpdate(Utility.RandomFloat(4,8))
endEvent

event OnUpdate()
	if(isWatching)
		watcher.ClearLookAt()
		watcher = None
	endIf
	; Free reference
	Clear()
endEvent