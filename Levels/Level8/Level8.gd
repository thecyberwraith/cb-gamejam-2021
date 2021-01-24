extends Node2D

onready var level_core: LevelCore = get_node("LevelCore")
onready var todos: Todos = level_core.get_todos()
onready var bases: Array = get_tree().get_nodes_in_group('bases')

func _ready():
	todos.add_todo(Todos.Tasks.BULB, len(bases))
	
	for base in bases:
		base.connect("net_bulb_placed", self, "update_bulb_count")
		
		if base is TimedBulbBase:
			base.connect("net_bulb_placed", self, "eject_other_bulbs")
	
	todos.connect("all_tasks_complete", level_core, "level_success")

func update_bulb_count(amount: int):
	todos.delta_todo_progress(Todos.Tasks.BULB, amount)

func eject_other_bulbs(amount: int):
	print('Ejecting some bulbs...')
	if amount == -1:
		for base in bases:
			if !(base is TimedBulbBase) and base.bulb_placed:
				base.eject_bulb()
