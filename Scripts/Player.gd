extends CharacterBody2D

const UP_DIRECTION := Vector2.UP

@onready var animation := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var hunger := $Hunger
@onready var player_alive := true

@export var speed := 300.0

signal ate_tile(position: Vector2)
signal game_end

func _physics_process(_delta):
	if not player_alive:
		return
	
	var _horizontal_direction = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	var _vertical_direction = (
		 Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
		
	var is_idling :=  is_zero_approx(velocity.x) and is_zero_approx(velocity.y)
	var is_running := not is_zero_approx(velocity.x) or not is_zero_approx(velocity.y)

	var hunger_diff

	velocity.x = _horizontal_direction * speed
	velocity.y = _vertical_direction * speed

	if is_idling:
		hunger_diff = 0
		animation.play("Idle")
		if animation.current_animation_position > 1.4: # time of animation when the deer is eating
			hunger_diff = 0.1
			ate_tile.emit(position)
	elif is_running:
		hunger_diff = -0.2
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

	hunger.value += hunger_diff
	if (is_zero_approx(hunger.value)):
		game_over()

	set_up_direction(UP_DIRECTION)
	move_and_slide()

func _on_crosshair_shot(pos: Vector2):
	if pos.distance_to(position) < 5:
		animation.play("Death")
		game_over()

func _on_ate_tile(_position):
	hunger.value += 0.1

func game_over():
	if player_alive:
		speed = 0
		game_end.emit()
		player_alive = false
