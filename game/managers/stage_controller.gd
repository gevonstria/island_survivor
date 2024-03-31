extends Node

const FADE_TIME = 1.0

var thread = Thread.new()
var is_stage_changing = false

func _enter_tree() -> void:
	EventSystem.STA_change_stage.connect(start_change_stage_sequence)

func _ready() -> void:
	start_change_stage_sequence(StageConfig.Keys.MainMenu)

func start_change_stage_sequence(key):
	if is_stage_changing:
		return
		
	is_stage_changing = true
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.GAM_game_fade_in.emit(FADE_TIME, game_faded_in.bind(key))
	EventSystem.BUL_destroy_all_bulletins.emit()
	
func game_faded_in(key):
	for child in get_children():
		child.queue_free()
	EventSystem.BUL_destroy_all_bulletins.emit()
	
	thread.start(load_stage.bind(key))
	
func load_stage(key):
	var new_stage = StageConfig.get_stage(key)
	call_deferred_thread_group("add_child", new_stage)
	new_stage.loading_complete.connect(loading_complete)
	new_stage.loading_complete.emit()
	call_deferred_thread_group("join_thread")
	
func join_thread() -> void:
	thread.wait_to_finish()
	
func loading_complete():
	EventSystem.GAM_game_fade_out.emit(FADE_TIME)
	is_stage_changing = false
	
