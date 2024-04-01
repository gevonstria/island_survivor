extends Node3D

@export var constructable_holder : Node3D

@onready var items: Node3D = $Items

func _enter_tree() -> void:
	EventSystem.SPA_spawn_scene.connect(spawn_scene)
	EventSystem.SPA_spawn_vfx.connect(spawn_vfx)
	
func spawn_scene(scene, tform, is_constructable=false):
	var obj = scene.instantiate()
	obj.global_transform = tform
	items.add_child(obj)
	
	if is_constructable:
		constructable_holder.add_child(obj)
		EventSystem.GAM_update_navmesh.emit()
	else:
		if not obj in items.get_children():
			items.add_child(obj)
		
func spawn_vfx(scene, tform):
	var vfx= scene.instantiate()
	vfx.global_transform = tform
	add_child(vfx)
	if vfx is GPUParticles3D:
		vfx.emitting = true
		
	get_tree().create_timer(2.0, false).timeout.connect(vfx.queue_free)
