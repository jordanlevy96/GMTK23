extends Sprite2D

@onready var player := get_owner().get_node("Player")
@onready var navigation := $NavigationAgent2D
var tween: Tween

signal shot

func _physics_process(_delta):
	if position.distance_to(player.position) < 7:
		shot.emit()

func aim():
	if tween:
		# not sure if this is necessary?
		tween.kill()
	tween = create_tween()

	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)

	navigation.target_position = player.global_position
	# var dir: Vector2 = navigation.get_next_path_position()
	var dir: Vector2 = player.global_position
	tween.tween_property(self, "position", dir, 2)

func _on_crosshair_timer_timeout():
	aim()
