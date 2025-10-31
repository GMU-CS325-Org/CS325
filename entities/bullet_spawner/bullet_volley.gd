class_name BulletVolley extends Node2D


@export var beat : int ##Beat that this volley gets fired

@export var bullet_prefab : PackedScene #The bullets to be fired. Loops through the array if multiple are provided
@export var color : DamageComponent.DamageColor
@export var targeted : bool = false #true if the bullets are aimed at the player, false if not
@export var quantity : int = 1 #the number of bullets spawned. should set spacing manually if higher than 1
@export var offset_degrees : float
@export var spacing_degrees : float = 0
@export var speed : float = 0.0 #the speed the bullet travels

@export var wiggle_freq : float = 0.0
@export var wiggle_dist : float = 0.0 #bullet will move between two points on beat
@export var curved : float = 0.0 #changes the flight trajectory of a bullet to curve
#index 0 is the x value. index 1 is the y value

func fire() -> void:
	var shoot_dir : Vector2
	
	if targeted:
		shoot_dir = self.global_position.direction_to(Player.instance.global_position)
	else:
		shoot_dir = Vector2.DOWN
	
	shoot_dir = shoot_dir.rotated(deg_to_rad(offset_degrees))
	
	var initial_shoot_angle : float = -spacing_degrees*(quantity-1)*0.5
	
	for i in range(0,quantity):
		var bullet_instance : Bullet = bullet_prefab.instantiate()
		bullet_instance.set_color(color)
		bullet_instance.direction = shoot_dir.rotated(deg_to_rad(initial_shoot_angle+spacing_degrees*i))
		bullet_instance.speed = speed
		bullet_instance.curving = curved
		bullet_instance.wiggle_freq = wiggle_freq
		bullet_instance.wiggle_dist = wiggle_dist
		add_sibling(bullet_instance)
