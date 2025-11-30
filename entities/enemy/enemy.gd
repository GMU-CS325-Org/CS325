extends CharacterBody2D

@export var sprites : bosses

enum bosses{
	trumphanta,
	piper,
	john
}

func _ready() -> void:
	# Connect to the health component's killed signal
	# This fires when health reaches 0
	$HealthComponent.killed.connect(_on_killed)
	$AnimatedSprite2D.play(str(sprites))

func _on_killed() -> void:
	print("Enemy died!")
	queue_free()  # Remove enemy from scene


func _on_health_component_damaged() -> void:
	$AudioStreamPlayer.play()
