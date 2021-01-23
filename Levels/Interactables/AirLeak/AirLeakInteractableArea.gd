extends InteractableArea

class_name AirLeakInteractableArea

signal patched

func can_interact(astronaut):
	return astronaut.current_interaction != null and astronaut.current_interaction.descriptor == 'torch'

func on_interact(astronaut):
	emit_signal("patched")
