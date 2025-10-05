class_name Gun extends Node2D

@export var bullet : PackedScene
@onready var bullet_container : Node2D = BulletContainer.instance

var has_primary_action : bool = true
var has_secondary_action : bool = true

func _ready() -> void:
	BeatSync.eighth_beat.connect(_reset_primary)
	BeatSync.quarter_beat.connect(_reset_secondary)
	
func primary_fire() -> void:
	pass

func secondary_fire() -> void:
	pass

func _reset_primary() -> void:
	has_primary_action = true
	
func _reset_secondary() -> void:
	has_secondary_action = true
	
