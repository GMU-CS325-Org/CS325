class_name Coin extends Bullet


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$HealthComponent.killed.connect(on_hit)


func on_hit() -> void:
	var closest : Node2D
	var closest_dist : float = 1000000
	for target in get_tree().get_nodes_in_group("coin_shootable"):
		if !(target is HurtboxComponent):
			assert(false,target.get_parent().to_string()+" is invalid target")
		
		if target.health_component.health <= 0:
			continue
		
		var dist : float = global_position.distance_squared_to(target.global_position)
		if dist < closest_dist:
			closest = target
			closest_dist = dist
	
	
	if closest != null:
		print("hits "+closest.get_parent().to_string())
		if closest is HurtboxComponent:
			$Control.show()
			$Control.rotation = global_position.angle_to_point(closest.global_position)
			$Control.size.x = sqrt(closest_dist)
			var damage_amount = $HealthComponent.max_health-$HealthComponent.health
			damage_component.damage = damage_amount+2
			closest.hit(damage_component)
		else:
			assert(false,"invalid collision")
	
	await get_tree().create_timer(0.1).timeout
	queue_free()
