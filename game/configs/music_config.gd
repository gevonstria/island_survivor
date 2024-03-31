class_name MusicConfig

enum Keys {
	IslandAmbiance,
	MainMenuMusic
}

const FILE_PATHS := {
	Keys.IslandAmbiance: "res://audio/music/island_ambience.ogg",
	Keys.MainMenuMusic: "res://audio/music/transfixed_main_theme.ogg"
}

static func get_audio_stream(key):
	return load(FILE_PATHS.get(key))
