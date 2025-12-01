extends Control


func _ready() -> void:
	BeatSync.play(load("res://level/level_data/death_scene.tres"))

func _on_button_pressed() -> void:
	SceneSwitch.change_scene_to_file("res://ui/main_menu.tscn")
