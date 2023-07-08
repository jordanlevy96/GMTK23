extends CharacterBody2D

const UP_DIRECTION := Vector2.UP

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed := 300.0
@export var jump_strength := 1500.0
@export var gravity := 4500.0

var _jumps_made := 0
var _velocity := Vector2.ZERO


func _physics_process(delta):
	var _horizontal_direction = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
		
	var is_falling := _velocity.y > -1.0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("ui_up") and not is_falling
	var is_idling := is_on_floor() and is_zero_approx(_velocity.x)
	var is_running := is_on_floor() and not is_zero_approx(_velocity.x)

	_velocity.x = _horizontal_direction * speed
	_velocity.y = gravity * delta

	if is_idling:
		animation.play("Idle")
	elif is_running:
		if _velocity.x < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		animation.play("Run")
		
	if is_jumping:
		_velocity.y = -jump_strength 
		animation.play("Run")

	set_velocity(_velocity)
	set_up_direction(UP_DIRECTION)
	move_and_slide()
	_velocity = velocity
