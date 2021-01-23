extends Camera2D

class_name AstronautCamera

var handler: AstronautHandler

func initialize(a_handler: AstronautHandler):
	handler = a_handler

func _process(_delta):
	if handler:
		self.position = handler.get_current_astronaut_position()
