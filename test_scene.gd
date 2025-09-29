extends Node2D




func _on_button_pressed() -> void:
	print("startin")
	BeatSync.play(preload("res://level/level_data/test_level.tres"))
