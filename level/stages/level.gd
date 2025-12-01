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
	$GUI.set_enemy_max_hp($enemy/HealthComponent.max_health)
	$GUI.update_enemy_health($enemy/HealthComponent.max_health)
	$enemy/HealthComponent.damaged.connect($GUI.update_enemy_health)
	$enemy/HealthComponent.killed.connect(win)

func win() -> void:
	get_tree().change_scene_to_file("res://ui/win_scene.tscn")
