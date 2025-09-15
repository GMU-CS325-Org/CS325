extends Node2D




func _on_button_pressed() -> void:
	BeatSync.current_level = load("res://level/level_data/test_level.tres")
	print("startin")
	BeatSync.play()
