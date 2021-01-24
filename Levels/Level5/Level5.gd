extends Node2D

onready var level_core: LevelCore = get_node("LevelCore")
onready var todos: Todos = level_core.get_todos()
onready var airlock: BreakableAirLock = get_node("Ship/BreakableAirLock")

func _ready():
	var leaks: Array = get_tree().get_nodes_in_group('leaks')
	
	for leak in leaks:
		leak.connect("patched", todos, "delta_todo_progress", [Todos.Tasks.LEAK, 1])
	
	todos.add_todo(Todos.Tasks.LEAK, len(leaks))
	todos.connect("all_tasks_complete", level_core, "level_success")
