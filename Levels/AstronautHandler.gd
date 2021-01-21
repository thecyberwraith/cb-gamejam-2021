extends Node2D

class_name AstronautHandler

const Astronaut = preload("res://Characters/Astronaut/Astronaut.tscn")

var current: Astronaut
var current_index: int

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_switch_astronaut"):
		current_index = (current_index + 1) % get_child_count()
		current = self.get_child(current_index)
	
	current.handle_process(delta)

func initialize(starts: Node2D):
	# Put an astronaut at each location
	for start_position in starts.get_children():
		var astronaut = Astronaut.instance()
		self.add_child(astronaut)
		astronaut.position = start_position.position
	
	current_index = 0
	current = self.get_child(current_index)

func get_current_astronaut_position() -> Vector2:
	if current:
		return current.position
	
	return Vector2(0,0)
	
