extends Interactable

func start_interaction():
	EventSystem.STA_change_stage.emit(StageConfig.Keys.Credits)
