extends CharacterBody3D

@export var normal_speed = 3.0
@export var sprint_speed = 5.0
@export var jump_velocity = 4.0
@export var gravity = .2
@export var mouse_sensitivity = .005

@onready var head: Node3D = $Head
@onready var interaction_ray_cast: RayCast3D = $Head/InteractionRayCast
@onready var equippable_item_holder: Node3D = $Head/EquippableItemHolder


func _enter_tree() -> void:
	EventSystem.PLA_freeze_player.connect(set_freeze.bind(true))
	EventSystem.PLA_unfreeze_player.connect(set_freeze.bind(false))
	
func set_freeze(freeze):
	set_process(!freeze)
	set_physics_process(!freeze)
	set_process_input(!freeze)
	set_process_unhandled_key_input(!freeze)
	
	
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	interaction_ray_cast.check_interaction()
	
func _physics_process(delta: float) -> void:
	move()
	
	if Input.is_action_just_pressed("use_item"):
		equippable_item_holder.try_to_use_item()
	
func move():
	var is_sprinting = false
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")
		
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
	else:
		velocity.y -= gravity
		is_sprinting = false
		
	var speed = 0
	if is_sprinting:
		speed = sprint_speed
	else:
		speed = normal_speed
	# get input
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#get current player rotation
	var direction = transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	
	velocity.z = direction.z * speed
	velocity.x = direction.x * speed
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)
		
func look_around(relative):
	rotate_y(-relative.x * mouse_sensitivity)
	head.rotate_x(-relative.y * mouse_sensitivity)
	head.rotation_degrees.x = clampf(head.rotation_degrees.x, -90, 90)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("open_crafting_menu"):
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.CraftingMenu, null)
	elif event.is_action_pressed("item_hot_key"):
		EventSystem.EQU_hotkey_pressed.emit(int(event.as_text()))
