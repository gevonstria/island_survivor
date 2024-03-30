extends Node

const INVENTORY_SIZE = 28
const HOTBAR_SIZE = 9

var inventory = []
var hotbar = []

func _enter_tree() -> void:
	EventSystem.INV_try_to_pickup_item.connect(try_to_pickup_item)
	EventSystem.INV_ask_update_inventory.connect(send_inventory)
	EventSystem.INV_switch_to_item_indexes.connect(switch_to_item_indexes)
	EventSystem.INV_add_item.connect(add_item)
	EventSystem.INV_delete_crafting_blueprint_cost.connect(delete_crafting_blueprint_cost)
	EventSystem.INV_delete_item_by_index.connect(delete_item_by_index)

func _ready() -> void:
	# init array size to inventory size
	inventory.resize(INVENTORY_SIZE)
	hotbar.resize(HOTBAR_SIZE)
	
	# add temp items
	inventory[0] = ItemConfig.Keys.Axe
	inventory[1] = ItemConfig.Keys.PickAxe
	inventory[2] = ItemConfig.Keys.Tent
	
func try_to_pickup_item(item_key, destroy_pickable):
	if not get_free_slots():
		return
	
	add_item(item_key)
	destroy_pickable.call()

func send_inventory():
	EventSystem.INV_inventory_updated.emit(inventory)
	
func send_hotbar():
	EventSystem.INV_hotbar_updated.emit(hotbar)

func switch_to_item_indexes(a, idx_a_in_hotbar, b, idx_b_in_hotbar):
	var item1 = inventory[a] if not idx_a_in_hotbar else hotbar[a]
	var item2 = inventory[b] if not idx_b_in_hotbar else hotbar[b]
	
	if not idx_a_in_hotbar:
		inventory[a] = item2
	else:
		hotbar[a] = item2
		
	if not idx_b_in_hotbar:
		inventory[b] = item1
	else:
		hotbar[b] = item1
		
	send_inventory()
	send_hotbar()
	
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
			
func delete_item_by_index(idx, is_in_hotbar):
	if is_in_hotbar:
		hotbar[idx] = null
		send_hotbar()
	else:
		inventory[idx] = null
		send_inventory()
