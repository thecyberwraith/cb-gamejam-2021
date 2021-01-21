extends Camera2D

const AstronautHandler = preload("res://Levels/AstronautHandler.tscn")

var handler: AstronautHandler

func initialize(handler: AstronautHandler):
	self.handler = handler

func _process(delta):
	if handler:
		self.position = handler.get_current_astronaut_position()
