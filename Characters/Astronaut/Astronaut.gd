extends RigidBody2D

class_name Astronaut

var aimed_direction: Vector2
var force = 5
func _ready():
	pass

func handle_process(_delta):
	var direction: Vector2 = _get_input_direction()
	
	if direction.length_squared() > 0:
		apply_impulse(Vector2(0,0), direction*force)

func _get_input_direction() -> Vector2:
	var input_map = {
		"ui_left": Vector2(-1,0),
		"ui_right": Vector2(1,0),
		"ui_up": Vector2(0,-1),
		"ui_down": Vector2(0,1)
	}
	
	var direction = Vector2(0,0)
	
	for action in input_map:
		if Input.is_action_pressed(action):
			direction += input_map[action]
	
	if direction.length_squared() > 0:
		direction = direction.normalized()
		
	return direction
