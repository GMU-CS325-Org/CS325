extends Control


func _ready() -> void:
	$AnimatedSprite2D.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://test_scene.tscn")


func _on_options_pressed() -> void:
	print("Coming Soon...")


func _on_exit_game_pressed() -> void:
	get_tree().exit()
