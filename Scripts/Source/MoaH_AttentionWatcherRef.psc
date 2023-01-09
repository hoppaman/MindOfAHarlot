Scriptname MoaH_AttentionWatcherRef extends ReferenceAlias

MoaH_CommonProperties property CommonProperties auto

Actor watcher = None
bool isWatching = false
event OnInit()
	Actor player = Game.GetPlayer()
	watcher = GetActorReference()
	if(watcher != None)
		watcher.SetLookAt(player, true)
		Debug.Notification("[MoaH] Attention " + watcher.GetDisplayName() + " is watching " + player.GetDisplayName())
		int handle = ModEvent.Create(CommonProperties.AttentionPlayerLookAtEventName)
		ModEvent.PushForm(handle, watcher)
		ModEvent.PushFloat(handle, watcher.GetDistance(player))
		ModEvent.Send(handle)
		RegisterForSingleUpdate(Utility.RandomFloat(4,8))
	else
		; Free reference
		Clear()
	endIf
endEvent

event OnUpdate()
	if(watcher != None)
		watcher.ClearLookAt()
		watcher = None
	endIf
	; Free reference
	GetOwningQuest().Stop()
endEvent