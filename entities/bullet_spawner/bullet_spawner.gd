extends Node2D

var age : int = 0 #number of beats the spawner has been active for
var restno : int = rests
var fireno : int = fire
var bullet_prefab = preload("res://entities/bullet_spawner/bullet.tscn")

@export var lifetime : int = 0 #number of beats until spawner is removed
@export var targeted : bool = false #true if the bullets are aimed at the player, false if not

@export var rests : int = 0 #number of beats to rest for after shooting. can't be 0
@export var fire : int = 0 #number of beats to shoot for, and then rest for
@export var beats : Array = [true, true] #whether to shoot on eighth notes or quarter notes
#index 0 is eighth noted. index 1 is quarter notes

@export var speed : float = 0.0 #the speed the bullet travels
@export var wiggle : float = 0.0 #bullet will move between two points on beat
@export var curved : float = 0.0 #changes the flight trajectory of a bullet to curve
#@export var direction : float = 0 #the direction that spawner is facing. matters for patterns not aimed at the player
@export_enum("colorless", "red", "blue") var color : int = 0 #the color of bullet shot

@export var size : float = 0.0 #the size of the bullet
@export var number : int = 1 #the number of bullets spawned. should set spacing manually if higher than 1
#@export var spacing : Array = [0.0, 0.0] #the spacing between bullets. should only be set if bullet_num is bigger than 1
#index 0 is the x value. index 1 is the y value

func _ready() -> void:
	BeatSync.quarter_beat.connect(_quarter_beat)
	BeatSync.eighth_beat.connect(_eighth_beat)
	
	#check if targeted and aim at player if so

func _quarter_beat():
	if (beats[1]): #beat skipped?
		_alive()
	
	elif (_rest_beat()):
		pass
	
	#fire a bullet
	else:
		_shoot()
	
	_alive()

func _eighth_beat():
	if (beats[0]): #beat skipped?
		_alive()
	
	elif (_rest_beat()):
		pass
	
	else:
		_shoot()
	
	_alive()

func _shoot():
	var bullet = bullet_prefab.instantiate()
	add_child(bullet)

func _beat_skipped():
	age += 1

func _rest_beat():
	if (rests <= 0):
		return false
	elif (fireno > 0):
		fireno -= 1
		restno = rests
		return false
	else:
		restno -= 1
		if (restno <= 0):
			fireno = fire
		return true

func _alive():
	if (lifetime == 0):
		pass
	else:
		age += 1
	if (age > lifetime):
		rests = 1
		restno = 1
		fire = 0
		fireno = 0
