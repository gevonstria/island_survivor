extends Stage

func _ready() -> void:
	get_tree().paused = false
	super()
	loading_complete.emit()
