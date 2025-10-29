class_name PlayerWeapons extends Node2D

@onready var guns : Array[Gun]

static var selected_gun : Gun


func _ready() -> void:
	for node : Node in get_children():
		if node is Gun:
			guns.append(node as Gun)
	
	selected_gun = guns[0]
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary_fire"):
		selected_gun.primary_fire()
		return
	
	if event.is_action_pressed("secondary_fire"):
		selected_gun.secondary_fire()
		return
	
	if event.is_action_released("primary_fire"):
		selected_gun.primary_released()
