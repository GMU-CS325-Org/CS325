extends Node2D

@export var stage = "res://level/level_data/stage_one.tres"
@export var player_weapon : int

func _ready() -> void:
	$Player/PlayerWeapons.weapon = player_weapon
	$Player/PlayerWeapons.selected_gun = $Player/PlayerWeapons.guns[player_weapon]
	$Player/PlayerWeapons.hide_unselected()
	print("startin")
	BeatSync.play(load(stage))
	$Player/ticker.speed_scale *= BeatSync.get_bpm() / 60
