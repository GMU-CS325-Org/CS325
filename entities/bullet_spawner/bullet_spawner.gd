class_name BulletSpawner extends Node2D

enum StartBeat{
	QUARTER,
	EIGHTH,
	SIXTEENTH,
}

var age : int = 0 #number of 16th notes the spawner has been active for
var bullet_volley_groups : Dictionary[int,BulletVolleyGroup]

@export var lifetime : int = 0 #number of beats until spawner is removed
@export var start_beat : StartBeat

func _ready() -> void:
	for node : Node2D in get_children():
		if not node is BulletVolley:
			continue
		var volley : BulletVolley = node
		
		if not bullet_volley_groups.has(volley.beat):
			bullet_volley_groups.set(volley.beat,BulletVolleyGroup.new())
		bullet_volley_groups.get(volley.beat).add_volley(volley)
	
	BeatSync.quarter_beat.connect(beat)
	BeatSync.eighth_beat.connect(beat)
	BeatSync.sixteenth_beat.connect(beat)
	
	#check if targeted and aim at player if so

func beat():
	if age == 0:
		if start_beat == StartBeat.QUARTER && BeatSync.current_quarter_crotchets % 4 != 0:
			return
		elif start_beat == StartBeat.EIGHTH && BeatSync.current_quarter_crotchets % 2 != 0:
			return

	if bullet_volley_groups.has(age):
		bullet_volley_groups.get(age).fire()
	
	age += 1
	if (age > lifetime):
		queue_free()
