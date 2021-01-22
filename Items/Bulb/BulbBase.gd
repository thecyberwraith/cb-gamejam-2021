extends Node2D

onready var bulb: Sprite = get_node("Bulb")
onready var base: Sprite = get_node("Base")
onready var interaction = get_node("InteractableBulbBaseArea")

func _ready():
	bulb.visible = false
	interaction.connect("on_place_bulb", bulb, "set", ["visible", true])
	interaction.connect("on_remove_bulb", bulb, "set", ["visible", false])
