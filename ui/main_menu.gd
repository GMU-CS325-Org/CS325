extends Control

var selected_weapon : bool = false #false is picktol, true is triangle

func _ready() -> void:
	Save.load()
	if GameSettings.completions & (1 << 0):
		$Badges/Stage1/Picktol.modulate.a = 1
	if GameSettings.completions & (1 << 1):
		$Badges/Stage1/Triangle.modulate.a = 1
	if GameSettings.completions & (1 << 2):
		$Badges/Stage2/Picktol.modulate.a = 1
	if GameSettings.completions & (1 << 3):
		$Badges/Stage2/Triangle.modulate.a = 1
	if GameSettings.completions & (1 << 4):
		$Badges/Stage3/Picktol.modulate.a = 1
	if GameSettings.completions & (1 << 5):
		$Badges/Stage3/Triangle.modulate.a = 1
		
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
		SceneSwitch.change_scene_to_file("res://level/stages/triangle/stage_one_triangle.tscn")
		GameSettings.current_stage = 0b000010
	else:
		SceneSwitch.change_scene_to_file("res://level/stages/picktol/stage_one_picktol.tscn")
		GameSettings.current_stage = 0b000001

func _on_stage_2_pressed() -> void:
	GameSettings.current_stage = 2
	if (selected_weapon):
		SceneSwitch.change_scene_to_file("res://level/stages/triangle/stage_two_triangle.tscn")
		GameSettings.current_stage = 0b001000
	else:
		SceneSwitch.change_scene_to_file("res://level/stages/picktol/stage_two_picktol.tscn")
		GameSettings.current_stage = 0b000100

func _on_stage_3_pressed() -> void:
	GameSettings.current_stage = 3
	if (selected_weapon):
		SceneSwitch.change_scene_to_file("res://level/stages/triangle/stage_three_triangle.tscn")
		GameSettings.current_stage = 0b100000
	else:
		SceneSwitch.change_scene_to_file("res://level/stages/picktol/stage_three_picktol.tscn")
		GameSettings.current_stage = 0b010000

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
	SceneSwitch.change_scene_to_file("res://ui/credits.tscn")
