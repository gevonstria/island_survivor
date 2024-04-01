class_name StageConfig

enum Keys {
	Island,
	MainMenu,
	Credits
}

const STAGE_PATHS = {
	Keys.Island: "res://stages/island.tscn",
	Keys.MainMenu: "res://stages/main_menu.tscn",
	Keys.Credits: "res://stages/credits.tscn"
}

static func get_stage(key):
	return load(STAGE_PATHS.get(key)).instantiate()

