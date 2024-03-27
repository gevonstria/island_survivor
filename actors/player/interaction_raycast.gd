extends RayCast3D

func check_interaction():
	if is_colliding() and Input.is_action_just_pressed("interact"):
		var collider = get_collider()
		if collider is Interactable:
			collider.start_interaction()
