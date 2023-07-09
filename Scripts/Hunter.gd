extends AnimatedSprite2D

func _on_crosshair_shot(_position: Vector2):
	if not is_playing():
		play()

func _on_animation_looped():
	stop()
