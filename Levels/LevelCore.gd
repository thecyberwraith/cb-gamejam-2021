extends Node2D

class_name LevelCore

# We expect the parent node to have a "Starts" node with position 2Ds
onready var starts = get_node("../Starts")

onready var pause_menu = get_node("GUI/PauseMenu")
onready var success_menu = get_node("GUI/SuccessMenu")
onready var todos_menu = get_node("GUI/Todos")

onready var camera = get_node("AstronautCamera")
onready var astronaut_handler = get_node("AstronautHandler")

var elapsed_time

func _ready():
	astronaut_handler.initialize(starts)
	camera.initialize(astronaut_handler)
	elapsed_time = 0

func _process(delta):
	elapsed_time += delta

func level_success():
	var save_file: SaveFile = SaveFile.new()
	var scene_string: String = get_tree().root.get_child(0).filename
	var index: int = save_file.get_level_from_scene(scene_string)
	
	var best_time: float = save_file.get_level_best_time(index)
	if best_time < 0 or best_time > elapsed_time:
		print('New record.')
		best_time = -1
		save_file.set_best_time(index, elapsed_time)
		save_file.save()
	
	success_menu.show_results(elapsed_time, best_time)

func get_astronauts():
	return astronaut_handler.get_children()

func get_todos():
	return todos_menu
