extends InteractableArea

class_name ButtonInteractableArea

signal pressed

func on_interact(astronaut):
	emit_signal("pressed")
