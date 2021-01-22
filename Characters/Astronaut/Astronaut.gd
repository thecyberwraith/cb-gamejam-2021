extends RigidBody2D

class_name Astronaut

onready var mount: Node2D = get_node("Mount")
onready var interaction_tracker: InteractionTracker = get_node("InteractionTracker")
onready var interaction_text: PanelContainer = get_node("InteractiveTextContainer")

const force = 5

var aimed_direction: Vector2
var current_interaction: Node2D

signal on_interactions

func _ready():
	connect("on_interactions", interaction_text, "on_interactions")
	interaction_text.visible = false
	
func get_mount_transform() -> Transform2D:
	return mount.transform
	
func handle_process(_delta):
	var direction: Vector2 = _get_input_direction()
	
	if direction.length_squared() > 0:
		apply_impulse(Vector2(0,0), direction*force)
	
	var next_interactable = interaction_tracker.find_first_active_interactable(self)
	
	emit_signal("on_interactions", next_interactable)

	if Input.is_action_just_pressed("ui_select"):
		if current_interaction != null:
			current_interaction.finish_interaction()
			current_interaction = null
		elif next_interactable:
			current_interaction = next_interactable.on_interact(self)
			print('I interacted with ', next_interactable.interact_text)

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
