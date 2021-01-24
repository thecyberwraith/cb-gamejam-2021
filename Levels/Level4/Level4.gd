extends Node2D

onready var level_core: LevelCore = get_node("LevelCore")
onready var todos: Todos = level_core.get_todos()
onready var airlock: BreakableAirLock = get_node("Ship/BreakableAirLock")
onready var base: BulbBase = get_node("BulbBase")

var door_ejected_before: bool = false

func _ready():
	todos.add_todo(Todos.Tasks.BULB, 1)
	airlock.connect("door_attached", self, "on_door_repaired")
	base.connect("on_bulb_placed", self, "on_bulb_placed")
	todos.connect("all_tasks_complete", level_core, "level_success")

func on_door_repaired():
	door_ejected_before = true
	if base.bulb_placed:
		base.eject_bulb()
		level_core.get_astronauts()[0].confuse()
		todos.set_todo_progress(Todos.Tasks.BULB, 0)
	todos.set_todo_progress(Todos.Tasks.DOOR, 1)

func on_bulb_placed():
	if !door_ejected_before:
		airlock.break_door(BreakableAirLock.Door.LEFT)
		door_ejected_before = true
		level_core.get_astronauts()[0].confuse()
		todos.add_todo(Todos.Tasks.DOOR, 1)
	
	todos.set_todo_progress(Todos.Tasks.BULB, 1)

