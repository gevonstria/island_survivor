extends Node

var bulletins = {}

func _enter_tree() -> void:
	EventSystem.BUL_create_bulletin.connect(create_bulletin)
	EventSystem.BUL_destroy_bulletin.connect(destroy_bulletin)

func create_bulletin(key, extra_arg):
	if bulletins.has(key):
		return
		
	var new_bulletin = BulletinConfig.get_bulletin(key)
	new_bulletin.initialize(extra_arg)
	add_child(new_bulletin)
	bulletins[key] = new_bulletin
	
func destroy_bulletin(key):
	if not bulletins.has(key):
		return
		
	bulletins[key].queue_free()
	bulletins.erase(key)
