extends Node2D

onready var level_core = get_node("LevelCore")
onready var base_1 = get_node("BulbBase")
onready var base_2 = get_node("BulbBase2")
onready var todos = level_core.get_todos()

var bulbs_placed: int = 0
func _ready():
	todos.add_todo(Todos.Tasks.BULB, 2)
	todos.connect("all_tasks_complete", level_core, "level_success")
	for base in [base_1, base_2]:
		base.connect("on_bulb_placed", self, "change_bulb_count", [1])
		base.connect("on_bulb_removed", self, "change_bulb_count", [-1])
	
func change_bulb_count(amt: int):
	bulbs_placed += 1
	todos.update_todo(Todos.Tasks.BULB, bulbs_placed)
