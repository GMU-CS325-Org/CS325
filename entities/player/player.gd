extends CharacterBody2D


@export_subgroup("Movement")
@export var speed : float = 300.0

@export var boost_curve : Curve

var boost_time : float = -1;

var action_taken : Array[bool] = [false,false]

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("boost") and boost_time < 0:
		#boost_time = 0

func _ready() -> void:
	BeatSync.quarter_beat.connect(_quarter_beat)
	BeatSync.eighth_beat.connect(_eighth_beat)
	BeatSync.sixteenth_beat.connect(_reset_beat)


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right","move_up", "move_down")
	var total_speed : float = speed
	if boost_time >= 0:
		total_speed += boost_curve.sample(boost_time)
		boost_time += delta
		if boost_time >= boost_curve.max_domain:
			boost_time = -1
		
	velocity = direction*total_speed
	#print(total_speed)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary_fire"):
		if not action_taken[0] && BeatSync.current_quarter_crotchets%4 == 0:
			print("Good")
			action_taken[0] = true
		elif action_taken[0]:
			print("bad (action taken)")
		elif BeatSync.current_quarter_crotchets%4 == 3:
			print("bad (too early)")
		else:
			print("bad (too late)")

func _reset_beat() -> void:
	action_taken[0] = false
	action_taken[1] = false

func _quarter_beat() -> void:
	$Sprite2D.scale = Vector2(0.6,0.6)
	boost_time = 0

func _eighth_beat() -> void:
	$Sprite2D.scale = Vector2(0.5,0.5)
