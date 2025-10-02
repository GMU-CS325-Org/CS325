class_name Bullet extends Area2D

var lol : int = -1

#color


@export var speed : float
@export var size : float
@export var damage_component : DamageComponent

func _ready() -> void:
	BeatSync.quarter_beat.connect(_quarter_beat)
	BeatSync.eighth_beat.connect(_eighth_beat)
	#speed = spd
	#size = sze

func _process(delta: float) -> void:
	#move_local_y(1)
	#move_local_x(1 * lol)
	pass

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		hurtbox.hit(damage_component)

func _quarter_beat():
	lol *= -1
	pass

func _eighth_beat():
	pass
