extends CharacterBody2D

const UP_DIRECTION := Vector2.UP

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed := 300.0

func _physics_process(_delta):
	var _horizontal_direction = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	var _vertical_direction = (
		 Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
		
	var is_idling :=  is_zero_approx(velocity.x) and is_zero_approx(velocity.y)
	var is_running := not is_zero_approx(velocity.x) or not is_zero_approx(velocity.y)

	velocity.x = _horizontal_direction * speed
	velocity.y = _vertical_direction * speed

	if is_idling:
		animation.play("Idle")
	elif is_running:
		if velocity.x < 0:
			sprite.flip_h = true
			animation.play("RunHorizontal")
		elif velocity.x > 0:
			sprite.flip_h = false
			animation.play("RunHorizontal")
		elif velocity.y < 0:
			animation.play("RunUp")
		elif velocity.y > 0:
			animation.play("RunDown")

	set_up_direction(UP_DIRECTION)
	move_and_slide()
