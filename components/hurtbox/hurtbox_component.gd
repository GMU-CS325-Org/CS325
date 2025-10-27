class_name HurtboxComponent extends Area2D



@export var health_component : HealthComponent
@export var allowed_damage_sources : Array[DamageComponent.Source]
@export var allowed_damage_colors : Array[DamageComponent.DamageColor]

func _ready() -> void:
	assert(health_component != null, "No health component added")



func hit(damage_component: DamageComponent) -> void:
	print(damage_component.damage)
	if allowed_damage_sources.has(damage_component.source):
		if damage_component.source == DamageComponent.Source.ENEMY:
			if not allowed_damage_colors.has(damage_component.color):
				return
			
			health_component.hurt(damage_component.damage)
		elif damage_component.source == DamageComponent.Source.PLAYER:
			print("hit enemy")
			health_component.hurt(damage_component.damage)
