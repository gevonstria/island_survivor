extends CharacterBody3D

const ANIM_BLEND = 0.2

enum States {
	Idle,
	Wander,
	Dead,
	Flee,
	Hurt
}
var state = States.Idle

@onready var idle_timer: Timer = $Timer/IdleTimer
@onready var wander_timer: Timer = $Timer/WanderTimer
@onready var disappear_after_timer: Timer = $Timer/DisappearAfterTimer
@onready var flee_timer: Timer = $Timer/FleeTimer

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("Player")

@onready var main_collision_shape: CollisionShape3D = $MainCollisionShape

@onready var meat_spawn_marker: Marker3D = $MeatSpawnMarker

@onready var animation_player : AnimationPlayer = %AnimationPlayer

@export var normal_speed = 0.6
@export var alarmed_speed = 1.8
@export var max_health = 80
@export var idle_animations :  Array[String] = []
@export var hurt_animations :  Array[String] = []
@export var turn_speed_weight = 0.07
@export var min_idle_time = 2.0
@export var max_idle_time = 7.0
@export var min_wander_time = 2.0
@export var max_wander_time = 4.0
@export var is_aggressive = false
@export var flee_timer_length = 3.0


var health = max_health

func _ready() -> void:
	animation_player.animation_finished.connect(animation_finished)
	
func animation_finished(anim_name):
	if state == States.Idle:
		animation_player.play(idle_animations.pick_random(), ANIM_BLEND)
	elif state == States.Hurt:
		if not is_aggressive:
			set_state(States.Flee)
		
func _physics_process(_delta: float) -> void:
	if state == States.Wander:
		wander_loop()
	elif state == States.Flee:
		flee_loop()
		
func wander_loop():
	look_forward()
	move_and_slide()
	
func flee_loop():
	look_forward()
	move_and_slide()
	
func look_forward():
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z) + PI, turn_speed_weight)
	
func pick_wander_velocity():
	var dir = Vector2(0,-1).rotated(randf() * PI * 2)
	velocity = Vector3(dir.x, 0, dir.y) * normal_speed
	
func _on_ilde_timer_timeout() -> void:
	set_state(States.Wander)


func _on_wander_timer_timeout() -> void:
	set_state(States.Idle)


func _on_disappear_after_timer_timeout() -> void:
	queue_free()
	
func _on_flee_timer_timeout() -> void:
	set_state(States.Idle)
	
func set_state(new_state):
	state = new_state
	
	match state:
		States.Idle:
			idle_timer.start(randf_range(min_idle_time, max_idle_time))
			animation_player.play(idle_animations.pick_random(), ANIM_BLEND)
		States.Wander:
			pick_wander_velocity()
			wander_timer.start(randf_range(min_wander_time, max_wander_time))
			animation_player.play("Walk", ANIM_BLEND)
		States.Dead:
			animation_player.play("Death", ANIM_BLEND)
			main_collision_shape.disabled = true
			var meat_scene = ItemConfig.get_pickable_item_resource(ItemConfig.Keys.RawMeat)
			EventSystem.SPA_spawn_scene.emit(meat_scene, meat_spawn_marker.global_transform)
			idle_timer.stop()
			wander_timer.stop()
			flee_timer.stop()
			set_physics_process(false)
			disappear_after_timer.start(10)
		States.Hurt:
			idle_timer.stop()
			wander_timer.stop()
			flee_timer.stop()
			animation_player.play(hurt_animations.pick_random(), ANIM_BLEND)
		States.Flee:
			pick_away_from_player_velocity()
			animation_player.play("Gallop", ANIM_BLEND)


func take_hit(weapon_item_resource) -> void:
	health -= weapon_item_resource.damage
	if state != States.Dead and health <= 0:
		set_state(States.Dead)
	elif not state in [States.Flee, States.Dead]:
		set_state(States.Hurt)
		
func pick_away_from_player_velocity():
	if not player:
		set_state(States.Idle)
		return
		
	var dir = player.global_position.direction_to(global_position)
	dir.y = 0
	velocity = dir.normalized() * alarmed_speed
	flee_timer.start(flee_timer_length)
	

