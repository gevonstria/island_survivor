extends TextureRect

@onready var icon_texture_rect: TextureRect = $MarginContainer/IconTextureRect
@onready var button: Button = $Button

var item_key = null

func set_item_key(key):
	item_key = key
	icon_texture_rect.texture = ItemConfig.get_item_resource(item_key).icon
	
