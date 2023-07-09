extends AnimatedSprite2D

@onready var player = get_owner().get_node("Player")
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _on_crosshair_shot(_position: Vector2):
	if not is_playing():
		play()
		audio_stream_player_2d.play(0.0)

func _on_animation_looped():
	stop()
