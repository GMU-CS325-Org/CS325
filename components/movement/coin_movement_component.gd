class_name CoinMovementComponent extends Node

@export var bullet : Bullet
@export var movement_curve : Curve

var age : float


func _physics_process(delta: float) -> void:
	if age >= movement_curve.max_domain:
		age = movement_curve.max_domain
	
	
	var movement_vector : Vector2 = bullet.direction*bullet.speed*movement_curve.sample(age)*delta
	bullet.move_local_x(movement_vector.x)
	bullet.move_local_y(movement_vector.y)
	
	age += delta
