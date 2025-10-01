extends Node

signal sixteenth_beat
signal eighth_beat
signal quarter_beat


var start_time : int
var time_delay : int
var current_level : LevelData
var current_time : float

var current_quarter_crotchets : int:
	set(new_val):
		current_quarter_crotchets = new_val
		if current_quarter_crotchets % 4 == 0:
			quarter_beat.emit()
		elif current_quarter_crotchets % 2 == 0:
			eighth_beat.emit()
		else:
			sixteenth_beat.emit()
		


func _ready() -> void:
	pass

func play(level : LevelData):
	current_level = level
	start_time = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	$SongPlayer.play()

func _process(delta: float) -> void:
	if current_level == null:
		return;
	
	_update_time()
	var quarter_crotchets : int = int(seconds_to_quarter_crotchets(current_time))
	if quarter_crotchets != current_quarter_crotchets:
		current_quarter_crotchets = quarter_crotchets


func _update_time() -> void:
	var time = (Time.get_ticks_usec() - start_time) / 1000000.0
	time -= current_level.first_note_time + time_delay
	current_time = max(0, time)
	
	
func seconds_to_quarter_crotchets(seconds:float) -> float:
	if current_level == null:
		printerr("No level selected")
	
	#var remaining_seconds := seconds # I don't think this is necessary in gdscript, but just to be safe
	#var total_crotchets := 1.0
	#total_crotchets += remaining_seconds*current_bpm/60 + 1
	return seconds*current_level.bpm/15.0
