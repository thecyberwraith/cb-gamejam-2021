extends VBoxContainer

onready var time = get_node("Time")
onready var to_levels = get_node("Buttons/Return")
onready var quit = get_node("Buttons/Quit")

const LEVEL_SELECT = "res://Menus/LevelsMenu.tscn"
func _ready():
	to_levels.connect("pressed", self, "return_to_level_select")
	quit.connect("pressed", get_tree(), "quit")

func return_to_level_select():
	get_tree().paused = false
	get_tree().change_scene(LEVEL_SELECT)
