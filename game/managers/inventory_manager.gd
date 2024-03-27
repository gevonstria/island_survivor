extends Node

const INVENTORY_SIZE = 28

var inventory = []

func _enter_tree() -> void:
	EventSystem.INV_try_to_pickup_item.connect(try_to_pickup_item)

func _ready() -> void:
	# init array size to inventory size
	inventory.resize(INVENTORY_SIZE)
	
func try_to_pickup_item(item_key, destroy_pickable):
	if not get_free_slots():
		return
	
	add_item(item_key)
	destroy_pickable.call()
	
func get_free_slots():
	return inventory.count(null)
	
func add_item(item_key):
	for i in inventory.size():
		if inventory[i] == null:
			inventory[i] = item_key
			break
