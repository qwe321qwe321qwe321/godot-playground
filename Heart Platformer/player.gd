extends CharacterBody2D


@export_range(0.0, 1000.0) var SPEED : float = 100.0
@export_range(0.0, 1000.0) var ACCELERATION : float = 400.0
@export_range(0.0, 1000.0) var FRICTION : float = 600.0
@export_range(0.0, 1000.0) var JUMP_VELOCITY : float = 400.0
@export_range(0, 0.5) var COYOTE_TIME : float = 0.15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var start_position := global_position
var coyote_timer := 0.0

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	update_coyote_timer(delta)
	handle_jump()

	var input_axis := Input.get_axis("ui_left", "ui_right")
	horizontal_movement(input_axis, delta)
	update_animation(input_axis)
	
	move_and_slide()

func apply_gravity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
func update_coyote_timer(delta_time: float) -> void:
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta_time
		
func can_jump() -> bool:
	return coyote_timer > 0.0
		
func handle_jump() -> void:
	# Handle Jump.
	if can_jump():
		if Input.is_action_just_pressed("ui_accept"):
			# -Y = Up.
			velocity.y = -JUMP_VELOCITY
			coyote_timer = 0
	else:
		if Input.is_action_just_released("ui_accept"):
			velocity.y = max(-JUMP_VELOCITY / 3, velocity.y)
			
func horizontal_movement(input_axis: float, delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, input_axis * SPEED, ACCELERATION * delta); 
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
			
func update_animation(input_axis: float) -> void:
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("jump")


func _on_hazard_detector_area_entered(area: Area2D) -> void:
	global_position = start_position
