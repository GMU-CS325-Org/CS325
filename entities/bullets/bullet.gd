class_name Bullet extends Area2D

var direction : Vector2
@export var speed : float
@export var size : float
@export var damage_component : DamageComponent

@export var color_sprites : Array[Texture]

@export var curving : float
@export var wiggle_freq : float
@export var wiggle_dist : float
@export var lifetime : int
var age : int = 0

func _ready() -> void:
	assert(color_sprites.size() == 3, "Missing sprites")
	BeatSync.quarter_beat.connect(_quarter_beat)
	BeatSync.eighth_beat.connect(_eighth_beat)
	BeatSync.sixteenth_beat.connect(_sixteenth_beat)

func set_color(color : DamageComponent.DamageColor) -> void:
	damage_component.color = color
	$Sprite2D.texture = color_sprites[int(color)]



func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		hurtbox.hit(damage_component)

func _quarter_beat():
	pass

func _eighth_beat():
	pass

func _sixteenth_beat():
	age += 1
	if (age >= lifetime):
		queue_free()
	pass
