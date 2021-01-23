extends RigidBody2D

class_name Astronaut

onready var mount: Node2D = get_node("Mount")
onready var interaction_tracker: InteractionTracker = get_node("InteractionTracker")
onready var interaction_text: PanelContainer = get_node("InteractiveTextContainer")

const force = 5

var aimed_direction: Vector2
var current_interaction: ConstantlyInteractable

signal on_interactions

func _ready():
	connect("on_interactions", interaction_text, "on_interactions")
	interaction_text.visible = false
	
func get_mount_transform() -> Transform2D:
	return mount.transform
	
func handle_process(_delta):
	handle_movement(_delta)
	handle_interactions()

func handle_movement(_delta):
	var direction: Vector2 = _get_input_direction()
	
	if direction.length_squared() > 0:
		apply_impulse(Vector2(0,0), direction*force)

func handle_interactions():
	var next_interactable = interaction_tracker.find_first_active_interactable(self)
	
	emit_signal("on_interactions", next_interactable)

	if Input.is_action_just_pressed("ui_select"):
		if next_interactable != null:
			# Warning, not sure if we can find ourselves with an interactable that
			# will try to replace the current while using the current...
			var result = next_interactable.on_interact(self)
			if result != null:
				if current_interaction != null:
					print('Error! Attempted to replace a interactable when one was there already!')
				current_interaction = result
		elif current_interaction != null:
			current_interaction.finish_interaction()
			current_interaction = null

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
