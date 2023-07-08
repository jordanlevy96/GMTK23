extends AnimatedSprite2D

func _on_crosshair_shot():
	play()

func _on_animation_looped():
	stop()
