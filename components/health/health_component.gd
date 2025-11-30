class_name HealthComponent extends Node

signal killed
signal damaged

@export var max_health : int

var health : int

var player_i_frames : bool = false

func _ready() -> void:
	health = max_health

func hurt(amount : int) -> void:
	if (player_i_frames):
		return
	health-=amount
	print(get_parent().name,": ",health," hp")
	damaged.emit(health)
	if (get_parent().name == "Player" && health > 0):
		player_i_frames = true
		$"../i-frames".show()
		$"../hurt".play()
		await get_tree().create_timer(1.0).timeout
		$"../i-frames".hide()
		player_i_frames = false
	if health <= 0:
		killed.emit()

func heal(amount : int) -> void:
	health = clampi(health+amount,0,max_health)
