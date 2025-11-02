extends Node2D




func _on_button_pressed() -> void:
	print("startin")
	BeatSync.play(preload("res://level/level_data/stage_two.tres"))


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	GameSettings.manual_audio_offset = $HSlider.value
