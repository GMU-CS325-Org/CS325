extends Control


func _ready() -> void:
	BeatSync.play(load("res://level/level_data/main_menu.tres"))

func _on_button_pressed() -> void:
	SceneSwitch.change_scene_to_file("res://ui/main_menu.tscn")
