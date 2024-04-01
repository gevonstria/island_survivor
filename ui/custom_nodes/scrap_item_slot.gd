extends TextureRect

signal item_scrapped

func _can_drop_data(_at_position: Vector2, slot: Variant) -> bool:
	return slot is InventorySlot and not slot is StartingCookingSlot and not slot is FinalCookingSlot
	
	
func _drop_data(_at_position: Vector2, slot: Variant) -> void:
	if slot is InventorySlot:
		EventSystem.INV_delete_item_by_index.emit(slot.get_index(), slot is HotBarSlot)
		item_scrapped.emit()
		
	
