class_name Tuba extends Gun

func primary_fire() -> void:
	if not has_primary_action:
		print("no primary")
		return
	has_primary_action = false
	rapid_fire(BeatSync.Note.QUARTER)

func secondary_fire() -> void:
	if not has_secondary_action:
		print("no secondary")
		return
	has_secondary_action = false
	rapid_fire(BeatSync.Note.EIGHTH)
	

func rapid_fire(note : BeatSync.Note):
	match BeatSync.get_timing(note):
		BeatSync.Timing.EARLY:
			print(note," early")
		BeatSync.Timing.GOOD:
			raycast_shoot(global_position.direction_to(get_global_mouse_position()),$DamageComponent)
		BeatSync.Timing.LATE:
			print(note," late")
