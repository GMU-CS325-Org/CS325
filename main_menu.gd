extends Control


func _on_play_button_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://test_scene.tscn")
	
	
func _on_option_button_pressed() -> void:
	pass # Replace with function body.
	
	
func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
	get_tree().quit()
