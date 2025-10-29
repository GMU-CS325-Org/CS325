class_name BulletSpawner extends Node2D

var age : int = 0 #number of 16th notes the spawner has been active for
var bullet_volley_groups : Dictionary[int,BulletVolleyGroup]

@export var lifetime : int = 0 #number of beats until spawner is removed
@export var start_beat : BeatSync.Note
@export var looping : bool

func _ready() -> void:
	for node : Node2D in get_children():
		if not node is BulletVolley:
			continue
		var volley : BulletVolley = node
		
		if not bullet_volley_groups.has(volley.beat):
			bullet_volley_groups.set(volley.beat,BulletVolleyGroup.new())
		bullet_volley_groups.get(volley.beat).add_volley(volley)
	
	BeatSync.quarter_beat.connect(_beat)
	BeatSync.eighth_beat.connect(_eighth_note)
	BeatSync.sixteenth_beat.connect(_sixteenth_note)
	
	#check if targeted and aim at player if so



func _eighth_note() -> void:
	if age == 0 && start_beat == BeatSync.Note.QUARTER:
		return
	_beat()

func _sixteenth_note() -> void:
	if age == 0 && start_beat != BeatSync.Note.SIXTEENTH:
		return
	_beat()

func _beat():

	if bullet_volley_groups.has(age):
		bullet_volley_groups.get(age).fire()
	
	age += 1
	if (age > lifetime):
		queue_free()
