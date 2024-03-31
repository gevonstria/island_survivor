class_name MusicConfig

enum Keys {
	IslandAmbiance
}

const FILE_PATHS := {
	Keys.IslandAmbiance: "res://audio/music/island_ambience.ogg"
}

static func get_audio_stream(key):
	return load(FILE_PATHS.get(key))
