extends Node2D

@export var patterns : Array[PackedScene]
var time : int = 0

var curr_pattern : Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BeatSync.quarter_beat.connect(inc)
	
	
func inc() -> void:
	if time == 0:
		curr_pattern = patterns.pick_random().instantiate()
		add_sibling(curr_pattern)
	
	if time > 27 && curr_pattern != null:
		curr_pattern.queue_free()
		curr_pattern=null
		
	time += 1
	if time > 31:
		time = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
