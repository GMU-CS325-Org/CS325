extends Node2D

var age : int = 0 #number of 16th notes the spawner has been active for
var bullet_volleys : Dictionary[int,BulletVolley]
var bullet_prefab = preload("res://entities/bullet_spawner/bullet.tscn")

@export var lifetime : int = 0 #number of beats until spawner is removed


func _ready() -> void:
	for node : Node2D in get_children():
		if not node is BulletVolley:
			continue
		var volley : BulletVolley = node
		bullet_volleys.set(volley.beat,volley)
	
	BeatSync.quarter_beat.connect(beat)
	BeatSync.eighth_beat.connect(beat)
	BeatSync.sixteenth_beat.connect(beat)
	
	#check if targeted and aim at player if so

func beat():
	if not bullet_volleys.has(age):
		return
	
	
	
	age+=1
	if (age > lifetime):
		queue_free()

#func _shoot():
	#var bullet = bullet_prefab.instantiate()
	#add_child(bullet)
#
#func _beat_skipped():
	#age += 1
#
#func _rest_beat():
	#if (rests <= 0):
		#return false
	#elif (fireno > 0):
		#fireno -= 1
		#restno = rests
		#return false
	#else:
		#restno -= 1
		#if (restno <= 0):
			#fireno = fire
		#return true
#
#func _alive():
	#if (lifetime == 0):
		#pass
	#else:
		#age += 1
	#if (age > lifetime):
		#rests = 1
		#restno = 1
		#fire = 0
		#fireno = 0
