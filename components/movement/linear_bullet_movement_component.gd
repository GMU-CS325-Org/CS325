class_name LinearBulletMovementComponent extends Node

@export var bullet : Bullet

func _physics_process(delta: float) -> void:
	var movement_vector : Vector2 = bullet.direction*bullet.speed
	bullet.move_local_x(movement_vector.x)
	bullet.move_local_y(movement_vector.y)
	pass
