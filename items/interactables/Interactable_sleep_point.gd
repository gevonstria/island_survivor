extends Interactable

func start_interaction():
	EventSystem.PLA_sleep.emit()
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.EnterTent)
