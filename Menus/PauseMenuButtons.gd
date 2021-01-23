extends VBoxContainer

const LevelSelect: PackedScene = preload("res://Menus/LevelsMenu.tscn")
const QuitMenu: PackedScene = preload("res://Menus/QuitMenu.tscn")

onready var container = get_parent().get_parent()
onready var resume = get_node("Resume")
onready var restart = get_node("Restart")
onready var levels = get_node("Levels")
onready var quit = get_node("Quit")

func _ready():
	var this_level: PackedScene = load(get_tree().root.get_child(0).filename)
	
	resume.connect("pressed", self, "unpause")
	restart.connect("pressed", self, "switch_scene_to", [this_level])
	levels.connect("pressed", self, "switch_scene_to", [LevelSelect])
	quit.connect("pressed", self, "switch_scene_to", [QuitMenu])
	container.hide()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		container.show()
		print("Pausing")
		get_tree().paused = true

func switch_scene_to(scene: PackedScene):
	get_tree().paused = false
	get_tree().change_scene_to(scene)

func unpause():
	get_tree().paused = false
	container.hide()

