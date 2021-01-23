extends Node2D

onready var level_core = get_node("LevelCore")
onready var base = get_node("BulbBase")

func _ready():
	base.connect("on_bulb_placed", level_core, "level_success")
