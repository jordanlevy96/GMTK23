extends Node2D

@onready var player := $Player
@onready var timer := $Player/CanvasLayer/GUI/HBoxContainer/Bars/TimerLabel
@onready var time := 0.0
@onready var game_over_label = $Player/GameOver

func _physics_process(delta):
	time += delta
	if player.player_alive:
		timer.text = 'Time: %.2f' % time	


func _on_player_game_end():
	# timer.text = "GG"
	# var tween = timer.create_tween()
	# tween.set_trans(Tween.TRANS_ELASTIC)
	# tween.set_ease(Tween.EASE_OUT)
	# tween.tween_property(timer, "position", player.position, 1)

	game_over_label.visible = true
	# var tween = game_over_label.create_tween()
	# tween.set_trans(Tween.TRANS_QUAD)
	# tween.tween_property(game_over_label, "scale", 2.5, 1)

