extends HBoxContainer

func _enter_tree() -> void:
	if not EventSystem.INV_hotbar_updated.is_connected(update_hotbar):
			EventSystem.INV_hotbar_updated.connect(update_hotbar)
	if not EventSystem.EQU_active_hotbar_slot_updated.is_connected(active_slot_updated):
		EventSystem.EQU_active_hotbar_slot_updated.connect(active_slot_updated)
	if not EventSystem.EQU_unequip_item.is_connected(active_slot_updated):
		EventSystem.EQU_unequip_item.connect(active_slot_updated.bind(null))

func update_hotbar(hotbar):
	for slot in get_children():
		slot.set_item_key(hotbar[slot.get_index()])
		
func active_slot_updated(idx):
	for slot in get_children():
		slot.set_highlighted(slot.get_index() == idx)
