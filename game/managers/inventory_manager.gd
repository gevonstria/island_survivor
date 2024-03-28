extends Node

const INVENTORY_SIZE = 28

var inventory = []

func _enter_tree() -> void:
	EventSystem.INV_try_to_pickup_item.connect(try_to_pickup_item)
	EventSystem.INV_ask_update_inventory.connect(send_inventory)
	EventSystem.INV_switch_to_item_indexes.connect(switch_to_item_indexes)
	EventSystem.INV_add_item.connect(add_item)
	EventSystem.INV_delete_crafting_blueprint_cost.connect(delete_crafting_blueprint_cost)

func _ready() -> void:
	# init array size to inventory size
	inventory.resize(INVENTORY_SIZE)
	
func try_to_pickup_item(item_key, destroy_pickable):
	if not get_free_slots():
		return
	
	add_item(item_key)
	destroy_pickable.call()

func send_inventory():
	EventSystem.INV_inventory_updated.emit(inventory)

func switch_to_item_indexes(a, b):
	var item_key1 = inventory[a]
	inventory[a] = inventory[b]
	inventory[b] = item_key1
	send_inventory()
	
func get_free_slots():
	return inventory.count(null)
	
func add_item(item_key):
	for i in inventory.size():
		if inventory[i] == null:
			inventory[i] = item_key
			break
			
	send_inventory()

func delete_item(item_key):
	if not inventory.has(item_key):
		return
		
	inventory[inventory.rfind(item_key)] = null
func delete_crafting_blueprint_cost(cost):
	for item_cost in cost:
		for i in item_cost.amount:
			delete_item(item_cost.item_key)
