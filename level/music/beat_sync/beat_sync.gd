extends Node

signal sixteenth_beat
signal eighth_beat
signal quarter_beat

enum Note{
	QUARTER,
	EIGHTH,
	SIXTEENTH,
}

enum Timing{
	EARLY,
	GOOD,
	LATE
}

var start_time : int
var time_delay : int
var current_level : LevelData
var current_time : float

var current_quarter_crotchets : int = -1:
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
	print("PLAYING", level.bpm)
	print(level)
	current_level = level
	$SongPlayer.stream = current_level.song
	start_time = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	$SongPlayer.play()

func _process(_delta: float) -> void:
	if current_level == null:
		return;
	
	_update_time()
	var quarter_crotchets : int = int(seconds_to_quarter_crotchets(current_time))
	if quarter_crotchets != current_quarter_crotchets:
		current_quarter_crotchets = quarter_crotchets


func _update_time() -> void:
	var time = (Time.get_ticks_usec() - start_time + GameSettings.manual_audio_offset) / 1000000.0
	time -= current_level.first_note_time + time_delay
	current_time = max(0, time)
	
	
func seconds_to_quarter_crotchets(seconds:float) -> float:
	if current_level == null:
		printerr("No level selected")
	
	#var remaining_seconds := seconds # I don't think this is necessary in gdscript, but just to be safe
	#var total_crotchets := 1.0
	#total_crotchets += remaining_seconds*current_bpm/60 + 1
	return seconds*current_level.bpm/15.0

func get_timing(note : Note) -> Timing:
	if current_level == null:
		return Timing.EARLY
	
	var target_crotchet : int
	match note:
		Note.QUARTER:
			target_crotchet = snappedi(current_quarter_crotchets,4)
		Note.EIGHTH:
			target_crotchet = snappedi(current_quarter_crotchets-2,4)+2
		_:
			assert(false,"Don't pass sixteenth notes into timing")
			pass
	
	var quarter_crotchets_off : float = seconds_to_quarter_crotchets(current_time)-target_crotchet
	if quarter_crotchets_off < -1:
		return Timing.EARLY
	if quarter_crotchets_off > 1:
		return Timing.LATE
	
	return Timing.GOOD
	

func get_bpm():
	return current_level.bpm
