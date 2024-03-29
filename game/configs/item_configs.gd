class_name ItemConfig

enum Keys {
	# pickables
	Stick,
	Stone,
	Plant,
	Mushroom,
	Fruit,
	Log,
	Coal,
	FlintStone,
	RawMeat,
	CookedMeat,
	# craftables
	Axe,
	PickAxe,
	Campfire,
	MultiTool,
	Rope,
	TinderBox,
	Torch,
	Tent,
	Raft
}

const CRAFTABLE_ITEM_KEYS = [
	Keys.Axe,
	#Keys.PickAxe,
	#Keys.Campfire,
	#Keys.MultiTool,
	Keys.Rope,
	#Keys.TinderBox,
	#Keys.Torch,
	#Keys.Tent,
	#Keys.Raft
]

const ITEM_RESOURCE_PATHS = {
	Keys.Stick: "res://resources/item_resources/stick_resource.tres",
	Keys.Stone: "res://resources/item_resources/stone_resource.tres",
	Keys.Plant: "res://resources/item_resources/plant_resource.tres",
	Keys.Axe: "res://resources/item_resources/axe.tres",
	Keys.Rope: "res://resources/item_resources/rope.tres"
}

static func get_item_resource(key):
	return load(ITEM_RESOURCE_PATHS.get(key))

const CraftingBlueprintResource_PATHS = {
	Keys.Axe: "res://resources/crafting_blueprint_resources/axe_blueprint.tres",
	Keys.Rope: "res://resources/crafting_blueprint_resources/rope_blueprint.tres"
}

static func get_crafting_blueprint_resource(key):
	return load(CraftingBlueprintResource_PATHS.get(key))
	
const EQUIPPABLE_ITEM_PATHS = {
	Keys.Axe: "res://items/equippables/equippable_axe_template.tscn"
}

static func get_equippable_item_resource(key):
	return load(EQUIPPABLE_ITEM_PATHS.get(key))
	
const PICKABLE_ITEM_PATHS = {
	Keys.Log: "res://items/interactables/rigid_pickable_log_template.tscn"
}

static func get_pickable_item_resource(key):
	return load(PICKABLE_ITEM_PATHS.get(key))
