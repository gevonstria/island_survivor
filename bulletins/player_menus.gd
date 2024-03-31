extends Bulletin
class_name PlayerMenuBase

@onready var inventory_container: GridContainer = $MarginContainer/HBoxContainer/VSplitContainer/InventoryNinePatchRect/InventoryContainer
@onready var item_description_label: Label = $MarginContainer/HBoxContainer/VSplitContainer/DescriptionNinePatchRect/MarginContainer/HBoxContainer/ItemDescriptionLabel
@onready var item_extra_info_label: Label = $MarginContainer/HBoxContainer/VSplitContainer/DescriptionNinePatchRect/MarginContainer/HBoxContainer/ItemExtraInfoLabel

func _enter_tree() -> void:
	EventSystem.INV_inventory_updated.connect(update_inventory)

func _ready() -> void:
	EventSystem.PLA_freeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	EventSystem.INV_ask_update_inventory.emit()
	
	
	for inventory_slot in inventory_container.get_children():
		inventory_slot.mouse_entered.connect(show_item_info.bind(inventory_slot))
		inventory_slot.mouse_exited.connect(hide_item_info)
		
	for hotbar_slot in get_tree().get_nodes_in_group("HotBarSlot"):
		hotbar_slot.mouse_entered.connect(show_item_info.bind(hotbar_slot))
		hotbar_slot.mouse_exited.connect(hide_item_info)
		
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
		
func update_inventory(inventory): 
	for i in inventory.size():
		inventory_container.get_child(i).set_item_key(inventory[i])

func close():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CraftingMenu)
	EventSystem.PLA_unfreeze_player.emit()
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
	
func show_item_info(inventory_slot):
	var item_key = inventory_slot.item_key
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or item_key == null:
		return
		
	var item_resource = ItemConfig.get_item_resource(item_key)
	item_description_label.text = item_resource.display_name +"\n" + item_resource.description
	
func hide_item_info():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
		
	item_description_label.text = ""
		
	
