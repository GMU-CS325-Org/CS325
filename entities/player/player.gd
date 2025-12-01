class_name Player extends CharacterBody2D

static var instance : Player

@export_subgroup("Movement")
@export var speed : float = 300.0

@export var boost_curve : Curve


var boost_time : float = -1;
var color : DamageComponent.DamageColor
var current_body : AnimatedSprite2D
@onready var health : HealthComponent = $HealthComponent

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("boost") and boost_time < 0:
		#boost_time = 0

	
func _ready() -> void:
	instance = self
	$HealthComponent.killed.connect(_on_death)
	BeatSync.quarter_beat.connect(_quarter_beat)
	$ticker.play("60_bpm")
	$BodyRed.play("idle")
	$BodyBlue.play("idle")
	$hitbox.play("idle")
	color = DamageComponent.DamageColor.RED
	current_body = $BodyRed
	$BodyRed.show()
	$BodyBlue.hide()
	$HurtboxComponent.allowed_damage_colors.clear()
	$HurtboxComponent.allowed_damage_colors.append(DamageComponent.DamageColor.BLUE)
	$HurtboxComponent.allowed_damage_colors.append(DamageComponent.DamageColor.WHITE)
	
func _quarter_beat() -> void:
	#$Sprite2D.scale = Vector2(0.6,0.6)
	#boost_time = 0
	#await get_tree().create_timer(0.1).timeout
	#$Sprite2D.scale = Vector2(0.5,0.5)
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("color_change"):
		match color:
			DamageComponent.DamageColor.RED:
				## Turn Blue
				color = DamageComponent.DamageColor.BLUE
				$BodyRed.hide()
				$BodyBlue.show()
				$HurtboxComponent.allowed_damage_colors.clear()
				$HurtboxComponent.allowed_damage_colors.append(DamageComponent.DamageColor.RED)
				$HurtboxComponent.allowed_damage_colors.append(DamageComponent.DamageColor.WHITE)
			DamageComponent.DamageColor.BLUE:
				color = DamageComponent.DamageColor.RED
				$BodyRed.show()
				$BodyBlue.hide()
				$HurtboxComponent.allowed_damage_colors.clear()
				$HurtboxComponent.allowed_damage_colors.append(DamageComponent.DamageColor.BLUE)
				$HurtboxComponent.allowed_damage_colors.append(DamageComponent.DamageColor.WHITE)
		
func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right","move_up", "move_down")
	var total_speed : float = speed
	animating()
	
	#if boost_time >= 0:
		#total_speed += boost_curve.sample(boost_time)
		#boost_time += delta
		#if boost_time >= boost_curve.max_domain:
			#boost_time = -1
		
	velocity = direction*total_speed
	if (Input.is_action_pressed("focus")):
		velocity *= 0.35
	#print(total_speed)
	move_and_slide()

func _on_death() -> void:
	SceneSwitch.change_scene_to_file("res://ui/death_scene.tscn")

func animating():
	if velocity.x > 0:
		$BodyRed.play("move_right")
		$BodyBlue.play("move_right")
	elif velocity.x < 0:
		$BodyRed.play("move_left")
		$BodyBlue.play("move_left")
	else: 
		$BodyRed.play("idle")
		$BodyBlue.play("idle")


func _on_health_component_killed() -> void:
	$death.play()
