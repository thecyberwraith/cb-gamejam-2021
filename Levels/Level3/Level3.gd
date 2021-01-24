extends Node2D

onready var level_core = get_node("LevelCore")
onready var todos = level_core.get_todos()
onready var base_1 = get_node("BulbBase")
onready var base_2 = get_node("BulbBase2")


func _ready():
	for base in [base_1, base_2]:
		base.connect("net_bulb_placed", self, "on_based_filled")
	
	todos.add_todo(Todos.Tasks.BULB, 2)
	todos.connect("all_tasks_complete", level_core, "level_success")

func on_based_filled(amount: int):
	todos.delta_todo_progress(Todos.Tasks.BULB, amount)
