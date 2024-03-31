extends TextureRect
class_name InventorySlot

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect

var item_key = null

func set_item_key(key):
	item_key = key
	update_icon()
	
func update_icon():
	if item_key == null:
		icon_texture_rect.texture = null
		return
		
	icon_texture_rect.texture = ItemConfig.get_item_resource(item_key).icon
	
func _get_drag_data(_at_position: Vector2) -> Variant:
	if item_key != null:
		var drag_preview = TextureRect.new()
		drag_preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		drag_preview.texture = icon_texture_rect.texture
		drag_preview.custom_minimum_size = Vector2(64, 64)
		drag_preview.modulate = Color(1, 1, 1, 0.7)
		set_drag_preview(drag_preview)
		EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
		return self
		
	return null
	
func _can_drop_data(_at_position: Vector2, origin_slot: Variant) -> bool:
	if item_key != null:
		if origin_slot is HotBarSlot:
			return ItemConfig.get_item_resource(item_key).is_equippable
		if origin_slot is StartingCookingSlot:
			return ItemConfig.get_item_resource(item_key).cooking_recipe_resource != null
		if origin_slot is FinalCookingSlot:
			return false
	return origin_slot is InventorySlot
	
func _drop_data(_at_position: Vector2, origin_slot: Variant) -> void:
	if origin_slot is StartingCookingSlot:
		var temp_key = item_key
		EventSystem.INV_add_item_by_index.emit(origin_slot.item_key, get_index(), self is HotBarSlot)
		origin_slot.set_item_key(temp_key)
		origin_slot.starting_ingredient_disabled.emit()
	elif origin_slot is FinalCookingSlot:
		EventSystem.INV_add_item_by_index.emit(origin_slot.item_key, get_index(), self is HotBarSlot)
		origin_slot.set_item_key(null)
		origin_slot.cooked_food_taken.emit()
	else:
		EventSystem.INV_switch_to_item_indexes.emit(
			origin_slot.get_index(),
			origin_slot is HotBarSlot,
			get_index(),
			self is HotBarSlot
		)
		
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
