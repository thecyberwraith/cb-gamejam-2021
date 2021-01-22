extends Node2D

onready var starts = get_node("Starts")
onready var astronaut_handler = get_node("AstronautHandler")
onready var camera = get_node("AstronautCamera")
onready var crate = get_node("Item")

func _ready():
	astronaut_handler.initialize(starts)
	camera.initialize(astronaut_handler)
