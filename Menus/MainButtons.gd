extends Node

onready var levels = get_node("LevelsButton")
onready var credits = get_node("CreditsButton")
onready var quit = get_node("QuitButton")

const LevelsMenu: PackedScene = preload("res://Menus/LevelsMenu.tscn")
const QuitMenu: PackedScene = preload("res://Menus/QuitMenu.tscn")
const CreditsMenu: PackedScene = preload("res://Menus/CreditsMenu.tscn")

func _ready():
	levels.connect("pressed", get_tree(), "change_scene_to", [LevelsMenu])
	credits.connect("pressed", get_tree(), "change_scene_to", [CreditsMenu])
	quit.connect("pressed", get_tree(), "change_scene_to", [QuitMenu])
