extends Node2D


func _ready() -> void:
	print("startin")
	BeatSync.play(load("res://level/level_data/stage_two.tres"))


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	GameSettings.manual_audio_offset = $HSlider.value
