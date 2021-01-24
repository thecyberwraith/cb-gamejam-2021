extends Node2D

onready var level_core = get_node("LevelCore")
onready var todos = level_core.get_todos()
onready var base_1 = get_node("BulbBase")
onready var base_2 = get_node("BulbBase2")

var bases_filled: int = 0

func _ready():
	base_1.connect("on_bulb_placed", self, "on_based_filled", [1])
	base_2.connect("on_bulb_placed", self, "on_based_filled", [1])
	base_1.connect("on_bulb_removed", self, "on_based_filled", [-1])
	base_2.connect("on_bulb_removed", self, "on_based_filled", [-1])
	todos.add_todo(Todos.Tasks.BULB, 2)
	todos.connect("all_tasks_complete", level_core, "level_success")

func on_based_filled(amount: int):
	bases_filled += amount
	todos.update_todo(Todos.Tasks.BULB, bases_filled)
