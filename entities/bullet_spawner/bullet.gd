extends Area2D

var lol : int = -1
var speed : float
var size : float
#color

func _ready() -> void:
	BeatSync.quarter_beat.connect(_quarter_beat)
	BeatSync.eighth_beat.connect(_eighth_beat)
	#speed = spd
	#size = sze

func _process(delta: float) -> void:
	#move_local_y(1)
	#move_local_x(1 * lol)
	pass

func _on_body_entered(_body) -> void:
	print("Pichuun!")

func _quarter_beat():
	lol *= -1
	pass

func _eighth_beat():
	pass
