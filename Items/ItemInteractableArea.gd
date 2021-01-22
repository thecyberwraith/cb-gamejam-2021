extends InteractableArea

class_name ItemInteractableArea

const HeldItem = preload("res://Items/HeldItem.tscn")
var item

func initialize(a_item):
	item = a_item

func can_interact(astronaut):
	return astronaut.current_interaction == null

func on_interact(astronaut) -> HeldItem:
	item.set_active(false)
	
	var held_item = HeldItem.instance()
	held_item.initialize(item, astronaut)

	return held_item
