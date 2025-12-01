extends Control

var selected_weapon : bool = false #false is picktol, true is triangle

func _ready() -> void:
	$AnimatedSprite2D.play()
	update_timing_offset()
	
	# Update stage button text with boss names
	$VBoxContainer/Stage1.text = "Stage 1: Trumphanta"
	$VBoxContainer/Stage2.text = "Stage 2: Paed Piper"
	$VBoxContainer/Stage3.text = "Stage 3: John"
	
	BeatSync.play(load("res://level/level_data/main_menu.tres"))

func _process(delta: float) -> void:
	match BeatSync.get_timing(BeatSync.Note.QUARTER):
		BeatSync.Timing.GOOD:
			$VBoxContainer/TestButton.text = "Now!"
		_:
			$VBoxContainer/TestButton.text = " "

func update_timing_offset() -> void:
	$VBoxContainer/TimingOffset.text = str("Timing Offset: ",$VBoxContainer/HSlider.value)
	GameSettings.manual_audio_offset = $VBoxContainer/HSlider.value

func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_weapon_select_pressed() -> void:
	selected_weapon = !selected_weapon
	if (selected_weapon):
		$"VBoxContainer/Weapon Select".text = "Weapon: Triangle"
	else:
		$"VBoxContainer/Weapon Select".text = "Weapon: Picktol"


func _on_stage_1_pressed() -> void:
	if (selected_weapon):
		get_tree().change_scene_to_file("res://level/stages/triangle/stage_one_triangle.tscn")
	else:
		get_tree().change_scene_to_file("res://level/stages/picktol/stage_one_picktol.tscn")


func _on_stage_2_pressed() -> void:
	if (selected_weapon):
		get_tree().change_scene_to_file("res://level/stages/triangle/stage_two_triangle.tscn")
	else:
		get_tree().change_scene_to_file("res://level/stages/picktol/stage_two_picktol.tscn")


func _on_stage_3_pressed() -> void:
	if (selected_weapon):
		get_tree().change_scene_to_file("res://level/stages/triangle/stage_three_triangle.tscn")
	else:
		get_tree().change_scene_to_file("res://level/stages/picktol/stage_three_picktol.tscn")


func _on_timing_offset_change(value: float) -> void:
	update_timing_offset()

func _on_test_button_pressed() -> void:
	match BeatSync.get_timing(BeatSync.Note.QUARTER):
		BeatSync.Timing.EARLY:
			$VBoxContainer/Feedback.text = "Early"
		BeatSync.Timing.GOOD:
			$VBoxContainer/Feedback.text = "Good!"
		_:
			$VBoxContainer/Feedback.text = "Late"


func _on_difficulty_item_selected(index: int) -> void:
	GameSettings.difficulty = index

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/credits.tscn")

