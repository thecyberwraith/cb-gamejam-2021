extends Control

onready var button = get_node("VBoxContainer/Button")
onready var level = get_node("VBoxContainer/Level")
onready var description = get_node("VBoxContainer/Description")
onready var time = get_node("VBoxContainer/Time")

signal play_level

var scene: String

func _ready():
	button.connect("pressed", self, "share_button")

func share_button():
	emit_signal("play_level", scene)

func populate(a_scene: String, lvl: int, desc: String, best: float):
	button.disabled = false
	level.text = "Level %s" % (lvl + 1)
	if best > 0:
		time.text = "Best time: %s seconds" % best
	description.text = desc
	scene = a_scene
