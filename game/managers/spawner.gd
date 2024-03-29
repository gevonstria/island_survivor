extends Node3D

@onready var items: Node3D = $Items

func _enter_tree() -> void:
	EventSystem.SPA_spawn_scene.connect(spawn_scene)
	
func spawn_scene(scene, tform):
	var obj = scene.instantiate()
	obj.global_transform = tform
	items.add_child(obj)
