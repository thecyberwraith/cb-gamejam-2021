extends VBoxContainer

const LevelSelect = preload("res://Menus/LevelsMenu.tscn")

onready var container = get_parent().get_parent()
onready var resume = get_node("Resume")
onready var restart = get_node("Restart")
onready var levels = get_node("Levels")
onready var quit = get_node("Quit")

func _ready():
	resume.connect("pressed", self, "unpause")
	restart.connect("pressed", self, "restart")
	levels.connect("pressed", self, "change_scene")
	quit.connect("pressed", get_tree(), "quit")
	container.hide()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		container.show()
		print("Pausing")
		get_tree().paused = true

func restart():
	get_tree().paused = false
	var this_scene = get_tree().root.get_child(0).filename
	get_tree().change_scene(this_scene)

func change_scene():
	get_tree().paused = false
	get_tree().change_scene_to(LevelSelect)

func unpause():
	get_tree().paused = false
	container.hide()

