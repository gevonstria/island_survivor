extends Bulletin

var prompt_text = ""

func initialize(prompt):
	if prompt is String:
		prompt_text = "[F] " + prompt

func _ready() -> void:
	$Label.text = prompt_text
