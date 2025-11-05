extends CharacterBody2D
func _ready() -> void:
	# Connect to the health component's killed signal
	# This fires when health reaches 0
	$HealthComponent.killed.connect(_on_killed)
	$AnimatedSprite2D.play("idle")

func _on_killed() -> void:
	print("Enemy died!")
	queue_free()  # Remove enemy from scene
