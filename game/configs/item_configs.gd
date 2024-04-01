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
	Keys.PickAxe,
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
	Keys.PickAxe: "res://resources/item_resources/pickaxe.tres",
	Keys.Rope: "res://resources/item_resources/rope.tres",
	Keys.Log: "res://resources/item_resources/log_item_resource.tres",
	Keys.Mushroom: "res://resources/item_resources/mushroom.tres",
	Keys.Coal: "res://resources/item_resources/coal_item_resource.tres",
	Keys.FlintStone: "res://resources/item_resources/flint_stone_resource.tres",
	Keys.RawMeat: "res://resources/item_resources/raw_meat_item_resource.tres",
	Keys.Tent: "res://resources/item_resources/tent_resource.tres",
	Keys.Campfire: "res://resources/item_resources/campfire_resource.tres",
	Keys.CookedMeat: "res://resources/item_resources/cooked_meat.tres",
	Keys.Raft: "res://resources/item_resources/raft.tres"
}

static func get_item_resource(key):
	return load(ITEM_RESOURCE_PATHS.get(key))

const CraftingBlueprintResource_PATHS = {
	Keys.Axe: "res://resources/crafting_blueprint_resources/axe_blueprint.tres",
	Keys.Rope: "res://resources/crafting_blueprint_resources/rope_blueprint.tres",
	Keys.PickAxe: "res://resources/crafting_blueprint_resources/pickaxe_blueprint.tres"
}

static func get_crafting_blueprint_resource(key):
	return load(CraftingBlueprintResource_PATHS.get(key))
	
const EQUIPPABLE_ITEM_PATHS = {
	Keys.Axe: "res://items/equippables/equippable_axe_template.tscn",
	Keys.PickAxe: "res://items/equippables/equippable_pickaxe_template.tscn",
	Keys.Mushroom: "res://items/equippables/equippable_mushroom_template.tscn",
	Keys.Tent: "res://items/equippables/equippable_tent_template.tscn",
	Keys.Campfire: "res://items/equippables/equippable_campfire_template.tscn",
	Keys.CookedMeat: "res://items/equippables/equippable_cooked_meat_template.tscn",
	Keys.Raft: "res://items/equippables/equippable_raft_template.tscn"
	
}

static func get_equippable_item_resource(key):
	return load(EQUIPPABLE_ITEM_PATHS.get(key))
	
const PICKABLE_ITEM_PATHS = {
	Keys.Log: "res://items/interactables/rigid_pickable_log_template.tscn",
	Keys.Coal: "res://items/interactables/rigid_pickable_coal_template.tscn",
	Keys.FlintStone: "res://items/interactables/rigid_pickable_flintstone_template.tscn",
	Keys.RawMeat: "res://items/interactables/rigid_pickable_raw_meat_template.tscn"
}

static func get_pickable_item_resource(key):
	return load(PICKABLE_ITEM_PATHS.get(key))
	
const CONSTRUCTABLE_SCENES_PATHS = {
	Keys.Tent: "res://objects/constructables/constructable_tent.tscn",
	Keys.Campfire: "res://objects/constructables/constructable_campfire.tscn",
	Keys.Raft: "res://objects/constructables/constructable_raft.tscn"
}

static func get_constructable_scene(key):
	return load(CONSTRUCTABLE_SCENES_PATHS.get(key))
	

