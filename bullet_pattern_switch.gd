extends Node2D

@export var patterns : Array[PackedScene]
@export var thresholds : Array[int]
var pattern_inc : int = 0

var curr_pattern : Node2D = null

func _ready() -> void:
	$"../enemy/HealthComponent".damaged.connect(inc)
	$"../enemy/HealthComponent".killed.connect(dead)
	curr_pattern = patterns[pattern_inc].instantiate()
	print(curr_pattern.name)
	add_sibling.call_deferred(curr_pattern)

func inc(hp : int):
	if (hp < thresholds[pattern_inc]):
		pattern_inc += 1
		curr_pattern.queue_free()
		if GameSettings.difficulty == 1:
			Player.instance.health.heal(1)
		curr_pattern = null
		if (pattern_inc > thresholds.size() - 1): #prevents grabbing a null index when final pattern is done
			return
		else:
			await get_tree().create_timer(0.5).timeout
			curr_pattern = patterns[pattern_inc].instantiate()
			add_sibling(curr_pattern)
			$"../enemy/HealthComponent".health = thresholds[pattern_inc - 1] #makes sure patterns aren't skipped
	pass

func dead() -> void:
	if (curr_pattern != null):
		curr_pattern.queue_free()

#func inc() -> void:
	##if time == 0:
		##curr_pattern = patterns.pick_random().instantiate()
		##add_sibling(curr_pattern)
	##
	##if time > 27 && curr_pattern != null:
		##curr_pattern.queue_free()
		##curr_pattern=null
		##
	##time += 1
	##if time > 31:
		##time = 0
	#pass
