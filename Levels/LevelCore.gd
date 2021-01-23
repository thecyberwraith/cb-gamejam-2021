extends Node2D

# We expect the parent node to have a "Starts" node with position 2Ds
onready var starts = get_node("../Starts")

onready var pause_menu = get_node("GUI/PauseMenu")
onready var success_menu = get_node("GUI/SuccessMenu")
onready var camera = get_node("AstronautCamera")
onready var astronaut_handler = get_node("AstronautHandler")

func _ready():
	astronaut_handler.initialize(starts)
	camera.initialize(astronaut_handler)

func level_success():
	success_menu.visible = true
	get_tree().paused = true
