extends Node2D

onready var bulb: Sprite = get_node("Bulb")
onready var base: Sprite = get_node("Base")
onready var interaction = get_node("InteractableBulbBaseArea")

signal on_bulb_placed
signal on_bulb_removed

func _ready():
	bulb.visible = false
	interaction.connect("on_place_bulb", self, "on_bulb_placed_callback")
	interaction.connect("on_remove_bulb", self, "on_bulb_removed_callback")

func on_bulb_placed_callback():
	bulb.visible = true
	emit_signal("on_bulb_placed")

func on_bulb_removed_callback():
	bulb.visible = false
	emit_signal("on_bulb_removed")
