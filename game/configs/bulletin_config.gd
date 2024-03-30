class_name BulletinConfig

enum Keys {
	InteractionPrompt,
	CraftingMenu,
	CookingMenu
}

const BULLETIN_PATHS = {
	Keys.InteractionPrompt: "res://bulletins/interaction_prompt.tscn",
	Keys.CraftingMenu: "res://bulletins/crafting_menu.tscn",
	Keys.CookingMenu: "res://bulletins/cooking_menu.tscn"
}

static func get_bulletin(key):
	return load(BULLETIN_PATHS.get(key)).instantiate()
