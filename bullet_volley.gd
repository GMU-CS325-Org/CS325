class_name BulletVolley extends Node2D

@export var beat : int ##Beat that this volley gets fired

@export var targeted : bool = false #true if the bullets are aimed at the player, false if not

@export var rests : int = 0 #number of beats to rest for after shooting. can't be 0
@export var fire : int = 0 #number of beats to shoot for, and then rest for
@export var beats : Array = [true, true] #whether to shoot on eighth notes or quarter notes
#index 0 is eighth noted. index 1 is quarter notes

@export var speed : float = 0.0 #the speed the bullet travels
@export var wiggle : float = 0.0 #bullet will move between two points on beat
@export var curved : float = 0.0 #changes the flight trajectory of a bullet to curve
#@export var direction : float = 0 #the direction that spawner is facing. matters for patterns not aimed at the player

@export var size : float = 0.0 #the size of the bullet
@export var number : int = 1 #the number of bullets spawned. should set spacing manually if higher than 1
#@export var spacing : Array = [0.0, 0.0] #the spacing between bullets. should only be set if bullet_num is bigger than 1
#index 0 is the x value. index 1 is the y value
