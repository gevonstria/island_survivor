extends EquippableItem
class_name EquippableWeapon

@onready var hit_check_marker: Marker3D = $hit_check_marker

var weapon_item_resource : WeaponItemResource

func _ready() -> void:
	hit_check_marker.position.z = -weapon_item_resource.attack_range
	super()
	
func check_hit():
	# project raycast
	var space_state = get_world_3d().direct_space_state
	var ray_query_params = PhysicsRayQueryParameters3D.new()
	ray_query_params.collide_with_areas = true
	ray_query_params.collide_with_bodies = false
	ray_query_params.collision_mask = 8 # hitbox binary value
	ray_query_params.from = global_position
	ray_query_params.to = hit_check_marker.global_position
	var result = space_state.intersect_ray(ray_query_params)
	
	if not result.is_empty():
		result.collider.take_hit(weapon_item_resource)
		
		EventSystem.SPA_spawn_vfx.emit(
			VFXConfig.get_vfx(result.collider.hit_particle_key),
			Transform3D(Basis(), result.position)
		)
		
func change_energy():
	EventSystem.PLA_change_energy.emit(weapon_item_resource.energy_change_per_use)
	
func play_swoosh_audio():
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.WeaponSwoosh)
