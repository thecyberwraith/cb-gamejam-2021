extends Control

onready var time: Label = get_node("PanelContainer/CenterContainer/Time")
onready var to_levels: Button = get_node("PanelContainer/CenterContainer/Buttons/Return")
onready var quit: Button = get_node("PanelContainer/CenterContainer/Buttons/Quit")
onready var best: Label = get_node("PanelContainer/CenterContainer/Best")

const LevelSelect = preload("res://Menus/LevelsMenu.tscn")
const QuitMenu = preload("res://Menus/QuitMenu.tscn")

func _ready():
	to_levels.connect("pressed", self, "switch_scene_to", [LevelSelect])
	quit.connect("pressed", self, "switch_scene_to", [QuitMenu])

func show_results(seconds: float, best_time: float):
	time.text = 'Mission Duration: %s seconds' % [seconds]
	if best_time > 0:
		best.text = 'Best Time: %s seconds' % best_time
	else:
		best.text = 'New record!'
	self.visible = true
	get_tree().paused = true

func switch_scene_to(scene: PackedScene):
	get_tree().paused = false
	get_tree().change_scene_to(scene)
