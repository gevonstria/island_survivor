extends HBoxContainer

func _enter_tree() -> void:
	EventSystem.INV_hotbar_updated.connect(update_hotbar)
	EventSystem.EQU_active_hotbar_slot_updated.connect(active_slot_updated)

func update_hotbar(hotbar):
	for slot in get_children():
		slot.set_item_key(hotbar[slot.get_index()])
		
func active_slot_updated(idx):
	for slot in get_children():
		slot.set_highlighted(slot.get_index() == idx)
