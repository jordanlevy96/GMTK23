extends Sprite2D

@onready var player := get_owner().get_node("Player")
@onready var navigation := $NavigationAgent2D
var tween: Tween

signal finished_tweening

func aim():
	print('aiming')
	if tween:
		print('killing tween')
		tween.kill()
	tween = create_tween()

	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)

	navigation.target_position = player.global_position
	# var dir: Vector2 = navigation.get_next_path_position()
	var dir: Vector2 = player.global_position
	tween.tween_property(self, "position", dir, 1)
	tween.tween_callback(emit_signal.bind(finished_tweening.get_name()))

func _on_timer_timeout():
	print('timer')
	aim()

func _on_finished_tweening():
	print('finished tweening')
	#aim()
