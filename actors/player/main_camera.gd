extends Camera3D

@onready var equippable_item_camera: Camera3D = $"../SubViewportContainer/SubViewport/EquippableItemCamera"

func _process(_delta: float) -> void:
	equippable_item_camera.global_transform = global_transform
