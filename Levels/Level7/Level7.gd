extends Node2D

onready var level_core: LevelCore = get_node("LevelCore")
onready var todos: Todos = level_core.get_todos()

func _ready():
	var bases = get_tree().get_nodes_in_group('bases')
	for base in bases:
		base.connect("net_bulb_placed", self, "net_bulb_placed")
	
	todos.connect("all_tasks_complete", level_core, "level_success")
	todos.add_todo(Todos.Tasks.BULB, len(bases))

func net_bulb_placed(amount: int):
	todos.delta_todo_progress(Todos.Tasks.BULB, amount)
