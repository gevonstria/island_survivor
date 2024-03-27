extends Interactable
class_name Pickable

@export var item_key : ItemConfig.Keys

@onready var parent = get_parent()

func start_interaction():
	print(parent)
	parent.queue_free()
