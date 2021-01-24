extends InteractableArea

class_name InteractableAirLockDoorRepair

signal repair_made

func can_interact(astronaut: Astronaut):
	return astronaut.is_holding('airlockdoor')

func on_interact(astronaut: Astronaut):
	astronaut.current_interaction.queue_free()
	astronaut.current_interaction = null
	print('We are interacting!')
	emit_signal('repair_made')
