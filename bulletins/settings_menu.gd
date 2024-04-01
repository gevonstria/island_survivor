extends FadingBulletin

@onready var music_volume_label: Label = $VBoxContainer/SettingContainer/WidgetContainer/MusicVolumeContainer/MusicVolumeLabel
@onready var sfx_volume_label: Label = $VBoxContainer/SettingContainer/WidgetContainer/SFXVolumeContainer/SFXVolumeLabel
@onready var resolution_scale_label: Label = $VBoxContainer/SettingContainer/WidgetContainer/ResolutionScaleContainer/ResolutionScaleLabel


var open_paused_menu_after_closing = false

func initialize(_open_paused_menu_after_closing):
	open_paused_menu_after_closing = _open_paused_menu_after_closing

func _on_music_volume_slider_value_changed(value: float) -> void:
	EventSystem.SET_music_volume_changed.emit(value)
	music_volume_label.text = str(snappedi(value * 100, 1)) + " %"

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	EventSystem.SET_sfx_volume_changed.emit(value)
	sfx_volume_label.text = str(snappedi(value * 100, 1)) + " %"

func _on_resolution_scale_slider_value_changed(value: float) -> void:
	EventSystem.SET_res_scale_changed.emit(value)
	resolution_scale_label.text = str(snappedi(value * 100, 1)) + " %"

func _on_ssaa_button_toggled(toggled_on: bool) -> void:
	EventSystem.SET_ssaa_changed.emit(toggled_on)

func _on_full_screen_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.SET_fullscreen_changed.emit(toggled_on)


func _on_close_button_pressed() -> void:
	fade_out()
	
	if open_paused_menu_after_closing:
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.PauseMenu, true)
		
func destroy_self():
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.SettingsMenu)
