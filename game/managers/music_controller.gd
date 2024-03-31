extends AudioStreamPlayer
class_name MusicController

func _ready() -> void:
	bus = "Music"
	play_music(MusicConfig.Keys.IslandAmbiance)

func play_music(key):
	stream = MusicConfig.get_audio_stream(key)
	play()
