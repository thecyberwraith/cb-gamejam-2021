extends Node

onready var levels = get_node("LevelsButton")
onready var credits = get_node("CreditsButton")
onready var options = get_node("OptionsButton")
onready var quit = get_node("QuitButton")

const LevelsMenu: PackedScene = preload("res://Menus/LevelsMenu.tscn")
const QuitMenu: PackedScene = preload("res://Menus/QuitMenu.tscn")

func _ready():
	levels.connect("button_up", get_tree(), "change_scene_to", [LevelsMenu])
	quit.connect("button_up", get_tree(), "change_scene_to", [QuitMenu])
