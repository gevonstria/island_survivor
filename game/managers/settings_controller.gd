extends Node

func _enter_tree() -> void:
	EventSystem.SET_music_volume_changed.connect(music_volume_changed)
	EventSystem.SET_sfx_volume_changed.connect(sfx_volume_changed)
	EventSystem.SET_res_scale_changed.connect(res_scale_changed)
	EventSystem.SET_ssaa_changed.connect(ssaa_changed)
	EventSystem.SET_fullscreen_changed.connect(fullscreen_change)
	
func music_volume_changed(volume_linear):
	AudioServer.set_bus_volume_db(1, linear_to_db(volume_linear))
	
func sfx_volume_changed(volume_linear):
	AudioServer.set_bus_volume_db(2, linear_to_db(volume_linear))
	
func res_scale_changed(scale):
	get_viewport().set_scaling_3d_scale(scale)
	
func ssaa_changed(enabled):
	get_viewport().set_screen_space_aa(
		Viewport.SCREEN_SPACE_AA_FXAA if enabled else Viewport.SCREEN_SPACE_AA_DISABLED
	)
	
func fullscreen_change(enabled):
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED
	)

	
