extends Control

var selected_weapon : bool = false #false is picktol, true is triangle

func _ready() -> void:
	$AnimatedSprite2D.play()


func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_weapon_select_pressed() -> void:
	selected_weapon = !selected_weapon
	if (selected_weapon):
		$"VBoxContainer/Weapon Select".text = "Weapon: Triangle"
	else:
		$"VBoxContainer/Weapon Select".text = "Weapon: Picktol"


func _on_stage_1_pressed() -> void:
	if (selected_weapon):
		get_tree().change_scene_to_file("res://level/stages/triangle/stage_one_triangle.tscn")
	else:
		get_tree().change_scene_to_file("res://level/stages/picktol/stage_one_picktol.tscn")


func _on_stage_2_pressed() -> void:
	if (selected_weapon):
		get_tree().change_scene_to_file("res://level/stages/triangle/stage_two_triangle.tscn")
	else:
		get_tree().change_scene_to_file("res://level/stages/picktol/stage_two_picktol.tscn")


func _on_stage_3_pressed() -> void:
	if (selected_weapon):
		get_tree().change_scene_to_file("res://level/stages/triangle/stage_three_triangle.tscn")
	else:
		get_tree().change_scene_to_file("res://level/stages/picktol/stage_three_picktol.tscn")
