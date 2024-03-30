extends Node3D
class_name EquippableItem

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mesh_holder: Node3D = $MeshHolder

func _ready() -> void:
	for child in mesh_holder.get_children():
		if child is VisualInstance3D:
			child.layers = 2

func try_to_use():
	if animation_player.is_playing():
		return
	
	animation_player.play("use_item")
