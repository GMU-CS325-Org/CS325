class_name Picktol extends Gun

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
			var new_bullet : Bullet = bullet.instantiate()
			bullet_container.add_child(new_bullet)
			new_bullet.global_position = global_position
			new_bullet.direction = global_position.direction_to(get_global_mouse_position())
		BeatSync.Timing.LATE:
			print(note," late")
