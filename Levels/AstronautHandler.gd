extends Node2D

class_name AstronautHandler

const Astronaut = preload("res://Characters/Astronaut/Astronaut.tscn")

const COLOR_LIST = [
	'ff3d3d',
	'2a4bff',
	'468f1d',
	'cbd92a',
	'921d88',
	'ffffff',
	'333333'
]

var current: Astronaut
var current_index: int

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_switch_astronaut"):
		current_index = (current_index + 1) % get_child_count()
		current = self.get_child(current_index)
	
	current.handle_process(delta)

func initialize(starts: Node2D) -> void:
	_populate_astronauts(starts)
	_randomize_colors()
	
	current_index = 0
	current = self.get_child(current_index)
	
func _populate_astronauts(starts: Node2D) -> void:
	# Put an astronaut at each location
	for start_position in starts.get_children():
		var astronaut = Astronaut.instance()
		self.add_child(astronaut)
		astronaut.position = start_position.position
	
func _randomize_colors() -> void:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	random.randomize()
	
	var choices = COLOR_LIST.duplicate()
	
	for astronaut in get_children():
		var index = random.randi_range(0, len(choices)-1)
		astronaut.modulate = choices[index]
		choices.remove(index)

func get_current_astronaut_position() -> Vector2:
	if current:
		return current.position
	
	return Vector2(0,0)
	
