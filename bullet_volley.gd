class_name BulletVolley extends Node2D


@export var beat : int ##Beat that this volley gets fired

@export var bullets : Array[PackedScene] #The bullets to be fired. Loops through the array if multiple are provided
@export var targeted : bool = false #true if the bullets are aimed at the player, false if not
@export var quantity : int = 1 #the number of bullets spawned. should set spacing manually if higher than 1
@export var spacing_degrees : float = 0
@export var speed : float = 0.0 #the speed the bullet travels

#index 0 is eighth noted. index 1 is quarter notes
#

#@export var wiggle : float = 0.0 #bullet will move between two points on beat
#@export var curved : float = 0.0 #changes the flight trajectory of a bullet to curve
##@export var direction : float = 0 #the direction that spawner is facing. matters for patterns not aimed at the player
#@export var spacing : Array = [0.0, 0.0] #the spacing between bullets. should only be set if bullet_num is bigger than 1
#index 0 is the x value. index 1 is the y value

func fire() -> void:
	print("Firing bullets")
	var shoot_dir : Vector2
	
	if targeted:
		shoot_dir = self.global_position.direction_to(Player.instance.global_position)
	else:
		shoot_dir = Vector2.DOWN
	
	var initial_shoot_angle : float = -spacing_degrees*(quantity-1)*0.5
	
	for i in range(0,quantity):
		var bullet_instance : Bullet = bullets[i%bullets.size()].instantiate()
		bullet_instance.direction = shoot_dir.rotated(deg_to_rad(initial_shoot_angle+spacing_degrees*i))
		bullet_instance.speed = speed
		add_sibling(bullet_instance)
