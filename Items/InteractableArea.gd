extends Area2D

class_name InteractableArea

onready var shape: CollisionShape2D = get_node("CollisionShape2D")

export var interact_text = 'Interact'
	
func set_interactable(interactable: bool):
	shape.set_deferred("disabled", !interactable)

func can_interact(_astronaut):
	return true

func on_interact(_astronaut):
	# Returns some object with a finish_interaction method if an ongoing effect
	# is required. Otherwise, return null.
	# Ex: To hold an item, return a HeldItem
	# Ex: To start a process, return an InteractiveProcess
	# To hit a button, return null (no further interaction)
	return null
