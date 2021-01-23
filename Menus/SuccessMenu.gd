extends Control

onready var time: Label = get_node("PanelContainer/CenterContainer/Time")
onready var to_levels: Button = get_node("PanelContainer/CenterContainer/Buttons/Return")
onready var quit: Button = get_node("PanelContainer/CenterContainer/Buttons/Quit")

const LevelSelect = preload("res://Menus/LevelsMenu.tscn")
const QuitMenu = preload("res://Menus/QuitMenu.tscn")

func _ready():
	to_levels.connect("pressed", self, "switch_scene_to", [LevelSelect])
	quit.connect("pressed", self, "switch_scene_to", [QuitMenu])

func show_results(seconds: float):
	time.text = 'Mission Duration: %s seconds' % [seconds]
	self.visible = true
	get_tree().paused = true

func switch_scene_to(scene: PackedScene):
	get_tree().paused = false
	get_tree().change_scene_to(scene)
