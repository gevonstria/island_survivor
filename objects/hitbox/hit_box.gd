extends Area3D

signal register_hit

func take_hit(weapon_item_resource):
	register_hit.emit(weapon_item_resource)
