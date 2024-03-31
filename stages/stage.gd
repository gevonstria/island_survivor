extends Node
class_name Stage

signal loading_complete

@export var music_to_play := MusicConfig.Keys.MainMenuMusic
#@export var scatter_nodes : Array[Node3D] = []
@export var show_mouse = false

func _ready() -> void:
	EventSystem.MUS_play_music.emit(music_to_play)
	
	if show_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
