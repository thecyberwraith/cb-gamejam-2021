extends InteractableArea

class_name InteractableAirLockDoorRepair

signal repair_made

func can_interact(astronaut):
	if astronaut.current_interaction != null and astronaut.current_interaction.descriptor == 'airlockdoor':
		return true

func on_interact(astronaut):
	astronaut.current_interaction.queue_free()
	astronaut.current_interaction = null
	print('We are interacting!')
	emit_signal('repair_made')
