extends AnimationPlayer

func _ready() -> void:
	await get_tree().physics_frame
	set_time(12)

func set_time(time):
	seek(time)
