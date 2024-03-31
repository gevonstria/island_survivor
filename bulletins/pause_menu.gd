extends Bulletin

const BG_NORMAL_COLOR = Color(0, 0, 0, .7)
const BG_FADE_TIME = 0.25
const BUTTON_FADE_TIME = 0.15
const TRANSPARENT_COLOR = Color(0, 0, 0, 0)

@onready var background: ColorRect = $ColorRect

@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var exit_button: Button = $VBoxContainer/ExitButton

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	background.color = TRANSPARENT_COLOR
	resume_button.modulate = TRANSPARENT_COLOR
	settings_button.modulate = TRANSPARENT_COLOR
	exit_button.modulate = TRANSPARENT_COLOR
	fade_in()
	EventSystem.HUD_hide_hud.emit()
	
func fade_in():
	create_tween().tween_property(background, "color", BG_NORMAL_COLOR, BG_FADE_TIME)
	
	var tween = create_tween()
	tween.tween_property(resume_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(settings_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	tween.tween_property(exit_button, "modulate", Color.WHITE, BUTTON_FADE_TIME)
	
func fade_out():
	var tween = create_tween()
	tween.tween_property(self, "modulate", BG_NORMAL_COLOR, BG_FADE_TIME / 2.0)
	tween.tween_callback(destroy_self)
	EventSystem.HUD_show_hud.emit()
	
func destroy_self():
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.PauseMenu)
	EventSystem.PLA_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	



func _on_resume_button_pressed() -> void:
	fade_out()


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.MainMenu)
