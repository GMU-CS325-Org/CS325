class_name BulletSpawner extends Node2D


var age : int = 0 #number of cooresponding notes the spawner has been active for
var bullet_volley_groups : Dictionary[int,BulletVolleyGroup]

@export var lifetime : int = 0 #number of beats until spawner is removed
@export var start_beat : BeatSync.Note
@export var looping : bool = true
@export var initial_offset = 0

func _ready() -> void:
	$Sprite2D.hide()
	age -= initial_offset
	for node : Node2D in get_children():
		if not node is BulletVolley:
			continue
		var volley : BulletVolley = node
		
		if not bullet_volley_groups.has(volley.beat):
			bullet_volley_groups.set(volley.beat,BulletVolleyGroup.new())
		bullet_volley_groups.get(volley.beat).add_volley(volley)
	
	
	BeatSync.quarter_beat.connect(_quarter_note)
	BeatSync.eighth_beat.connect(_eighth_note)
	BeatSync.sixteenth_beat.connect(_sixteenth_note)

func _process(delta: float) -> void:
	$spell.rotate(0.5 * delta)
	pass

func _quarter_note() -> void:
	if start_beat == BeatSync.Note.QUARTER:
		_beat()
	pass

func _eighth_note() -> void:
	if start_beat == BeatSync.Note.EIGHTH:
		_beat()
	pass

func _sixteenth_note() -> void:
	if start_beat == BeatSync.Note.SIXTEENTH:
		_beat()
	pass

func _beat():
	if bullet_volley_groups.has(age):
		bullet_volley_groups.get(age).fire()
	
	age += 1
	if (age > lifetime && looping):
		age = 0
	elif (age > lifetime && !looping):
		$spell.hide()
