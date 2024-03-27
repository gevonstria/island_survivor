extends Node

func _ready() -> void:
	change_stage(StageConfig.Keys.Island)

func change_stage(key):
	for child in get_children():
		child.queue_free()
		
	var new_stage = StageConfig.get_stage(key)
	add_child(new_stage)
