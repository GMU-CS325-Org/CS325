class_name DamageComponent extends Node

enum Source{
	PLAYER,
	ENEMY
}

enum DamageColor{
	WHITE,
	RED,
	BLUE
}


@export var color : DamageColor
@export var source : Source
@export var damage : int
