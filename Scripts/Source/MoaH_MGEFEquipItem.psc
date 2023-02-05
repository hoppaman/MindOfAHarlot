Scriptname MoaH_MGEFEquipItem extends ActiveMagicEffect  

Armor Property ToWear auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddItem(ToWear, 1, false)
	akTarget.EquipItem(ToWear, true, true)
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.UnequipItem(ToWear, true, true)
	akTarget.RemoveItem(ToWear, 1, true, None)
endEvent