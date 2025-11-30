extends Node2D

@export var stage = "res://level/level_data/stage_one.tres"

func _ready() -> void:
	print("startin")
	BeatSync.play(load(stage))
	$Player/ticker.speed_scale *= BeatSync.get_bpm() / 60


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	GameSettings.manual_audio_offset = $HSlider.value
