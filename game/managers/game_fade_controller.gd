extends ColorRect
class_name GameFadeController

func _enter_tree() -> void:
	EventSystem.GAM_game_fade_in.connect(fade_in)
	EventSystem.GAM_game_fade_out.connect(fade_out)
	
func fade_in(fade_time, maybe_callback = null):
	var tween = create_tween()
	tween.tween_property(self, "color", Color.BLACK, fade_time)
	tween.parallel().tween_method(set_master_volume, 1.0, 0.0, fade_time)
	
	if maybe_callback is Callable:
		tween.tween_callback(maybe_callback)

func set_master_volume(volume_linear):
	AudioServer.set_bus_volume_db(0, linear_to_db(volume_linear))
	
func fade_out(fade_time, maybe_callback = null):
	var tween = create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0 ,0), fade_time)
	tween.parallel().tween_method(set_master_volume, 0.0, 1.0, fade_time)
	
	if maybe_callback is Callable:
		tween.tween_callback(maybe_callback)
