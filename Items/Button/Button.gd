extends Node2D

class_name InteractableButton

onready var animation: AnimatedSprite = get_node("AnimatedSprite")
onready var area: ButtonInteractableArea = get_node("ButtonInteractableArea")

export var interact_text: String = "Press Button"

signal pressed

func _ready():
	area.interact_text = interact_text
	area.connect("pressed", self, "on_area_interacted")

func on_area_interacted():
	emit_signal("pressed")

func set_enabled(enabled: bool):
	if enabled:
		animation.play("enabled")
	else:
		animation.play("disabled")
	
	area.set_interactable(enabled)
