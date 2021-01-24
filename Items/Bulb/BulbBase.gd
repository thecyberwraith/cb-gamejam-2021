extends Node2D

class_name BulbBase

onready var bulb: Sprite = get_node("Bulb")
onready var base: Sprite = get_node("Base")
onready var interaction: InteractableBulbBaseArea = get_node("InteractableBulbBaseArea")

signal on_bulb_placed
signal on_bulb_removed
signal net_bulb_placed

var bulb_placed: bool = false

func _ready():
	bulb.visible = false
	interaction.connect("on_place_bulb", self, "on_bulb_placed_callback")
	interaction.connect("on_remove_bulb", self, "on_bulb_removed_callback")

func on_bulb_placed_callback():
	bulb_placed = true
	bulb.visible = true
	emit_signal("on_bulb_placed")
	emit_signal("net_bulb_placed", 1)

func on_bulb_removed_callback():
	bulb_placed = false
	bulb.visible = false
	emit_signal("on_bulb_removed")
	emit_signal("net_bulb_placed", -1)

func eject_bulb():
	bulb_placed = false
	bulb.visible = false
	emit_signal("on_bulb_removed")
	emit_signal("net_bulb_placed", -1)
	print('Ejecting Bulb')

	interaction.bulb.set_active(true)
	interaction.bulb.position = $EjectionPoint.global_position
	var random = RandomNumberGenerator.new()
	random.randomize()
	interaction.bulb.angular_velocity = random.randf_range(-4, 4)
	interaction.bulb.linear_velocity.x = random.randf_range(-15, 15)
	interaction.bulb.linear_velocity.y = random.randf_range(-15, 15)
	interaction.bulb = null
	interaction.interact_text = "Place Bulb"
