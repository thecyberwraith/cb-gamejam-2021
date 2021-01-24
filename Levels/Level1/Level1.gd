extends Node2D

onready var level_core = get_node("LevelCore")
onready var base = get_node("BulbBase")

func _ready():
	var todos: Todos = level_core.get_todos()
	todos.add_todo(Todos.Tasks.BULB, 1)
	todos.connect("all_tasks_complete", level_core, "level_success")
	base.connect("on_bulb_placed", self, "bulb_placed")
	
func bulb_placed():
	level_core.get_todos().update_todo(Todos.Tasks.BULB, 1)

