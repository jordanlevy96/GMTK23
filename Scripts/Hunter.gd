extends AnimatedSprite2D

@onready var player = get_owner().get_node("Player")

func _on_crosshair_shot(_position: Vector2):
	if not is_playing() and player.player_alive:
		play()

func _on_animation_looped():
	stop()
