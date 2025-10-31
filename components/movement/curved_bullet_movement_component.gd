class_name CurvedBulletMovementComponent extends Node

@export var bullet : Bullet
@export var rotation_curve : Curve
var sample_point : float = 0.0

func _physics_process(delta: float) -> void:
	var movement_vector : Vector2 = bullet.direction*bullet.speed
	bullet.move_local_x(movement_vector.x)
	bullet.move_local_y(movement_vector.y)
	sample_point += delta / 3.0
	bullet.rotate(bullet.curving * rotation_curve.sample(sample_point))
	pass
