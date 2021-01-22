extends Area2D

class_name InteractionTracker

var interactables: Array = []

func _ready():
	if not connect("area_entered", self, "on_area_enter") == OK:
		print('Connection Error')
	if not connect("area_exited", self, "on_area_exit") == OK:
		print('Another error')

func on_area_enter(area) -> void:
	if not area is InteractableArea:
		print('It is not interactable')
		return
		
	if interactables.find(area) < 0:
		interactables.append(area)
	print('There are ', len(interactables), ' interactables now')

func on_area_exit(area) -> void:
	if not area is InteractableArea:
		return
		
	var index = interactables.find(area)
	if index >= 0:
		interactables.remove(index)
	print('There are ', len(interactables), ' interactables left')

func find_first_active_interactable(astronaut) -> InteractableArea:
	for candidate in interactables:
		if candidate.can_interact(astronaut):
			return candidate
	
	return null
