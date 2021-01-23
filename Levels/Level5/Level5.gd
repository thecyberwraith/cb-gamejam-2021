extends Node2D

onready var level_core: LevelCore = get_node("LevelCore")
onready var airlock: BreakableAirLock = get_node("Ship/BreakableAirLock")
onready var leak: AirLeak = get_node("AirLeak")

func _process(_delta):
	if len(get_tree().get_nodes_in_group('leaks')) == 0:
		level_core.level_success()
