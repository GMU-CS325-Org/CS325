extends Node2D

@export var stage = "res://level/level_data/stage_one.tres"
@export var player_weapon : int

# Camera shake variables
var camera : Camera2D
var shake_amount : float = 0.0

func _ready() -> void:
	# Create and setup camera
	camera = Camera2D.new()
	add_child(camera)
	camera.position = Vector2(576.5, 324.5)  # Center of 1153x649 level
	camera.limit_left = 0
	camera.limit_right = 1153
	camera.limit_top = 0
	camera.limit_bottom = 649
	camera.enabled = true
	
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
	
	# Connect to player damage to trigger shake
	Player.instance.health.damaged.connect(_on_player_damaged)

func _on_player_damaged(_hp: int) -> void:
	shake_amount = 15.0  # Shake intensity

func _process(delta: float) -> void:
	# Apply and decay shake
	if shake_amount > 0:
		camera.offset = Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)
		shake_amount = lerp(shake_amount, 0.0, 5.0 * delta)  # Decay rate
	else:
		camera.offset = Vector2.ZERO

func win() -> void:
	get_tree().change_scene_to_file("res://ui/win_scene.tscn")
