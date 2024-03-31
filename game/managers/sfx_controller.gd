extends AudioStreamPlayer
class_name SFXController

func _enter_tree() -> void:
	EventSystem.SFX_play_sfx.connect(play_sfx)

func _ready() -> void:
	bus = "SFX"

func play_sfx(key):
	stream = SFXConfig.get_audio_stream(key)
	play()
