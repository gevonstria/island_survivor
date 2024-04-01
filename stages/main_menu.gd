extends Stage


func _ready() -> void:
	super()
	loading_complete.emit()

func _on_start_button_pressed() -> void:
	EventSystem.STA_change_stage.emit(StageConfig.Keys.Island)


func _on_settings_button_pressed() -> void:
	EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.SettingsMenu, false)


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
