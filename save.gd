class_name Save extends Resource

const SAVE_FILE := "user://save.tres" ## Filepath where the save file is loaded
@export_storage var completions : int = 0b000000

static func save() -> void:
	var save_data : Save = Save.new()
	save_data.completions = GameSettings.completions
	ResourceSaver.save(save_data, SAVE_FILE)
	

static func load() -> void:
	if ResourceLoader.exists(SAVE_FILE):
		var save_data : Save = ResourceLoader.load(SAVE_FILE)
		GameSettings.completions = save_data.completions
