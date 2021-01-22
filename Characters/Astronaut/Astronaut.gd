extends RigidBody2D

class_name Astronaut

onready var mount: Node2D = get_node("Mount")
onready var interaction_region: Area2D = get_node("Area2D")

const force = 5

var interactables: Array
var aimed_direction: Vector2
var carried_item: Node2D

func _ready():
	interaction_region.connect("body_entered", self, "set_interaction")
	interaction_region.connect("body_exited", self, "unset_interaction")

func set_interaction(body):
	if interactables.find(body) < 0:
		interactables.append(body)
	print('There are ', len(interactables), ' interactables now')

func unset_interaction(body):
	var index = interactables.find(body)
	if index >= 0:
		interactables.remove(index)
	print('There are ', len(interactables), ' interactables left')

func get_mount_transform() -> Transform2D:
	return mount.transform
	
func handle_process(_delta):
	var direction: Vector2 = _get_input_direction()
	
	if direction.length_squared() > 0:
		apply_impulse(Vector2(0,0), direction*force)
	
	if Input.is_action_just_pressed("ui_select"):
		if carried_item != null:
			carried_item.finish_interaction()
		elif len(interactables) > 0:
			for interactable in interactables:
				if interactable.has_method('interact'):
					carried_item = interactable.interact(self)
					break

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
