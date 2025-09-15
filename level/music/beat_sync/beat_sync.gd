extends Node

var start_time : int
var time_delay : int
var current_level : LevelData

var hit_err : Array[float]

func _ready() -> void:
	pass

func play():
	start_time = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	$SongPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if current_level == null:
		return
	if event.is_action_pressed("jump"):
		print(hit_err)
		
func test() -> void:
		
	var time = (Time.get_ticks_usec() - start_time) / 1000000.0
	time -= current_level.first_note_time + time_delay
	time = max(0, time)
	var crotchets = seconds_to_crotchet(time)
	var curr_hit_err : float = crotchets-roundf(crotchets)
	hit_err.append(curr_hit_err)
	print(curr_hit_err)
	
	
func seconds_to_crotchet(seconds:float) -> float:
	if current_level == null:
		printerr("No level selected")
	
	var remaining_seconds := seconds # I don't think this is necessary in gdscript, but just to be safe
	#var total_crotchets := 1.0
	#total_crotchets += remaining_seconds*current_bpm/60 + 1
	return remaining_seconds*current_level.bpm/60 + 1
