extends Node2D

onready var starts = get_node("Starts")
onready var astronaut_handler = get_node("AstronautHandler")
onready var camera = get_node("AstronautCamera")
onready var base = get_node("BulbBase")
onready var success = get_node("GUI/SuccessMenu")

func _ready():
	astronaut_handler.initialize(starts)
	camera.initialize(astronaut_handler)
	base.connect("on_bulb_placed", self, "level_completed")

func level_completed():
	success.visible = true
	get_tree().paused = true
