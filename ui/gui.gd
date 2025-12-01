extends CanvasLayer

func _ready() -> void:
	$PlayerHealth.max_value = Player.instance.health.max_health
	Player.instance.health.damaged.connect(update_player_health)
	update_player_health(Player.instance.health.max_health)

func update_player_health(new_hp : int) -> void:
	$PlayerHealth.value = Player.instance.health.health

func set_enemy_max_hp(amount : int) -> void:
	$BossHealth.max_value = amount
	
func update_enemy_health(new_hp : int) -> void:
	$BossHealth.value = new_hp
