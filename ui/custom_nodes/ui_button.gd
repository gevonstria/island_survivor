extends Button
class_name UIButton

func _ready() -> void:
	pressed.connect(clicked)
	
func clicked():
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
