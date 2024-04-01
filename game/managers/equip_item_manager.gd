extends Node

var active_hotbar_slot = null
var hotbar = []

func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(hotbar_updated)
	EventSystem.EQU_hotkey_pressed.connect(hotbar_pressed)
	EventSystem.EQU_delete_equip_item.connect(delete_equip_item)

func _ready() -> void:
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)
	
func hotbar_updated(_hotbar):
	hotbar = _hotbar
	
	if active_hotbar_slot != null and hotbar[active_hotbar_slot] == null:
		EventSystem.EQU_unequip_item.emit()
		active_hotbar_slot = null
	
func hotbar_pressed(hotkey):
	var idx = hotkey-1
	if hotbar[idx] == null:
		return
	if idx != active_hotbar_slot:
		active_hotbar_slot = idx
		EventSystem.EQU_equip_item.emit(hotbar[idx])
		EventSystem.EQU_active_hotbar_slot_updated.emit(idx)
	else:
		active_hotbar_slot = null
		EventSystem.EQU_unequip_item.emit()
		EventSystem.EQU_active_hotbar_slot_updated.emit(null)
		
func delete_equip_item():
	EventSystem.INV_delete_item_by_index.emit(active_hotbar_slot, true)
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)
	active_hotbar_slot = null
