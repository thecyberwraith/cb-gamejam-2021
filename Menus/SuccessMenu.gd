extends Control

onready var time: Label = get_node("PanelContainer/CenterContainer/Time")
onready var to_levels: Button = get_node("PanelContainer/CenterContainer/Buttons/Return")
onready var quit: Button = get_node("PanelContainer/CenterContainer/Buttons/Quit")

const LEVEL_SELECT = "res://Menus/LevelsMenu.tscn"

func _ready():
	to_levels.connect("pressed", self, "return_to_level_select")
	quit.connect("pressed", get_tree(), "quit")

func show_results(seconds: float):
	time.text = 'Mission Duration: %s seconds' % [seconds]
	self.visible = true
	get_tree().paused = true

func return_to_level_select():
	get_tree().paused = false
	get_tree().change_scene(LEVEL_SELECT)
