extends InteractableArea

class_name InteractableBulbBaseArea

var bulb

const HeldItem = preload("res://Items/HeldItem.tscn")

signal on_place_bulb
signal on_remove_bulb

func can_interact(astronaut: Astronaut):
	var base_has_bulb = bulb != null
	
	# Option 1, there is no bulb in the base, but there is a bulb on the player
	if astronaut.is_holding('bulb') and not base_has_bulb:
		return true
	# Option 2, there is a bulb in the base and the player isn't carrying anything
	elif astronaut.empty_handed() and base_has_bulb:
		return true
	
	return false

func on_interact(astronaut):
	var held_bulb: HeldItem = astronaut.current_interaction
	
	# Place bulb
	if held_bulb != null:
		print('Placing bulb')
		bulb = held_bulb.original
		emit_signal("on_place_bulb")
		held_bulb.queue_free()
		interact_text = "Remove Bulb"
		
		return null
	else:
		# Remove bulb
		emit_signal("on_remove_bulb")
		var item = HeldItem.instance()
		item.initialize(bulb.get_held_descriptor(), bulb, astronaut)
		bulb = null
		interact_text = "Place Bulb"
		
		return item
