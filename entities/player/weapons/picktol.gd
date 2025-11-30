class_name Picktol extends Gun

@export var coin : PackedScene

func primary_fire() -> void:
	has_secondary_action = false
	if not has_primary_action:
		print("no primary")
		return
	has_primary_action = false
	
	match BeatSync.get_timing(BeatSync.Note.QUARTER):
		BeatSync.Timing.EARLY:
			print("early")
		BeatSync.Timing.GOOD:
			raycast_shoot(global_position.direction_to(get_global_mouse_position()),$PistolDamageComponent)
			$picktol_sprite.play("strum")
			$picktol_sprite.set_frame(0)
			$Strum.play()
		BeatSync.Timing.LATE:
			print("late")
	

func secondary_fire() -> void:
	has_primary_action = false
	if not has_secondary_action:
		print("no secondary")
		return
	has_secondary_action = false
	
	match BeatSync.get_timing(BeatSync.Note.QUARTER):
		BeatSync.Timing.EARLY:
			print("early")
		BeatSync.Timing.GOOD:
			var new_bullet : Coin = coin.instantiate()
			bullet_container.add_child(new_bullet)
			new_bullet.global_position = global_position
			new_bullet.direction = global_position.direction_to(get_global_mouse_position())
			$picktol_sprite.play("flick")
			$picktol_sprite.set_frame(0)
			$Flick.play()
		BeatSync.Timing.LATE:
			print("late")
	
	
