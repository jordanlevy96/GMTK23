extends CanvasLayer

@onready var main = $Main
@onready var credits = $Credits


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")

func _on_credits_pressed():
	main.visible = not main.visible
	credits.visible = not credits.visible

func _on_quit_pressed():
	get_tree().quit()
