extends FadingBulletin

@onready var music_volume_label: Label = $VBoxContainer/SettingContainer/WidgetContainer/MusicVolumeContainer/MusicVolumeLabel
@onready var sfx_volume_label: Label = $VBoxContainer/SettingContainer/WidgetContainer/SFXVolumeContainer/SFXVolumeLabel
@onready var resolution_scale_label: Label = $VBoxContainer/SettingContainer/WidgetContainer/ResolutionScaleContainer/ResolutionScaleLabel
@onready var music_volume_slider: HSlider = $VBoxContainer/SettingContainer/WidgetContainer/MusicVolumeContainer/MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = $VBoxContainer/SettingContainer/WidgetContainer/SFXVolumeContainer/SFXVolumeSlider
@onready var resolution_scale_slider: HSlider = $VBoxContainer/SettingContainer/WidgetContainer/ResolutionScaleContainer/ResolutionScaleSlider
@onready var ssaa_button: CheckButton = $VBoxContainer/SettingContainer/WidgetContainer/SSAAButton
@onready var full_screen_check_button: CheckButton = $VBoxContainer/SettingContainer/WidgetContainer/FullScreenCheckButton

var open_paused_menu_after_closing = false

func initialize(_open_paused_menu_after_closing):
	open_paused_menu_after_closing = _open_paused_menu_after_closing
	
func _ready() -> void:
	EventSystem.SET_ask_settings_resource.emit(set_settings_visuals)
	
	music_volume_slider.value_changed.connect(_on_music_volume_slider_value_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_slider_value_changed)
	resolution_scale_slider.value_changed.connect(_on_resolution_scale_slider_value_changed)
	ssaa_button.toggled.connect(_on_ssaa_button_toggled)
	full_screen_check_button.toggled.connect(_on_full_screen_check_button_toggled)
	
	super()
	
func set_settings_visuals(settings_resource):
	update_music_label(settings_resource.music_volume)
	music_volume_slider.value = settings_resource.music_volume
	update_sfx_volume_label(settings_resource.sfx_volume)
	sfx_volume_slider.value = settings_resource.sfx_volume
	update_resolution_scale_label(settings_resource.res_scale)
	resolution_scale_slider.value = settings_resource.res_scale
	
	ssaa_button.button_pressed = settings_resource.ssaa_enabled
	full_screen_check_button.button_pressed = settings_resource.fullscreen_enabled

func _on_music_volume_slider_value_changed(value: float) -> void:
	EventSystem.SET_music_volume_changed.emit(value)
	update_music_label(value)
	
func update_music_label(value):
	music_volume_label.text = str(snappedi(value * 100, 1)) + " %"

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	EventSystem.SET_sfx_volume_changed.emit(value)
	update_sfx_volume_label(value)
	
func update_sfx_volume_label(value):
	sfx_volume_label.text = str(snappedi(value * 100, 1)) + " %"

func _on_resolution_scale_slider_value_changed(value: float) -> void:
	EventSystem.SET_res_scale_changed.emit(value)
	update_resolution_scale_label(value)
	
func update_resolution_scale_label(value):
	resolution_scale_label.text = str(snappedi(value * 100, 1)) + " %"

func _on_ssaa_button_toggled(toggled_on: bool) -> void:
	EventSystem.SET_ssaa_changed.emit(toggled_on)

func _on_full_screen_check_button_toggled(toggled_on: bool) -> void:
	EventSystem.SET_fullscreen_changed.emit(toggled_on)


func _on_close_button_pressed() -> void:
	fade_out()
	
	EventSystem.SET_save_settings.emit()
	
	if open_paused_menu_after_closing:
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.PauseMenu, true)
		
func destroy_self():
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.SettingsMenu)
