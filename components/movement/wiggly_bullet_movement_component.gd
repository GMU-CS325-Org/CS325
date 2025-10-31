class_name WigglyBulletMovementComponent extends Node

@export var bullet : Bullet
var time : float

func _physics_process(delta: float) -> void:
	var movement_vector : Vector2 = bullet.direction*bullet.speed
	bullet.move_local_x(movement_vector.x)
	bullet.move_local_y(movement_vector.y)
	time += delta
	bullet.move_local_x(get_cosine())
	pass

func get_cosine():
	return cos(time * bullet.wiggle_freq) * bullet.wiggle_dist
