extends CharacterBody2D

@export var hp : int = 100

func _ready() -> void:
	$HealthComponent.max_health = hp
	$HealthComponent.health = hp
	# Connect to the health component's killed signal
	# This fires when health reaches 0
	$HealthComponent.killed.connect(_on_killed)
	$AnimatedSprite2D.play("idle")

func _on_killed() -> void:
	print("Enemy died!")
	queue_free()  # Remove enemy from scene
