extends Interactable
class_name Pickable

@export var item_key : ItemConfig.Keys

@onready var parent = get_parent()

func start_interaction():
	EventSystem.INV_try_to_pickup_item.emit(item_key, destroy_self)
	
func destroy_self():
	parent.queue_free()
