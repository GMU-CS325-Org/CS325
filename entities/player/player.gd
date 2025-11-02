class_name Player extends CharacterBody2D

static var instance : Player

@export_subgroup("Movement")
@export var speed : float = 300.0

@export var boost_curve : Curve

var boost_time : float = -1;



#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("boost") and boost_time < 0:
		#boost_time = 0

	
func _ready() -> void:
	instance = self
	BeatSync.quarter_beat.connect(_quarter_beat)
	$ticker.play("60_bpm")

func _quarter_beat() -> void:
	#$Sprite2D.scale = Vector2(0.6,0.6)
	#boost_time = 0
	#await get_tree().create_timer(0.1).timeout
	#$Sprite2D.scale = Vector2(0.5,0.5)
	pass



func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right","move_up", "move_down")
	var total_speed : float = speed
	
	#if boost_time >= 0:
		#total_speed += boost_curve.sample(boost_time)
		#boost_time += delta
		#if boost_time >= boost_curve.max_domain:
			#boost_time = -1
		
	velocity = direction*total_speed
	if (Input.is_action_pressed("focus")):
		velocity *= 0.5
	#print(total_speed)
	move_and_slide()
