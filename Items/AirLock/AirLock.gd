extends Node2D

class_name AirLock

onready var left_door: KinematicBody2D = get_node("LeftDoor")
onready var right_door: KinematicBody2D = get_node("RightDoor")
onready var button: InteractableButton = get_node("Button")
onready var animator: AnimationPlayer = get_node("AnimationPlayer")

const LEFT_OPEN = "OpenLeft"
const RIGHT_OPEN = "OpenRight"

enum STATES {CLOSING, OPENING, FREE}
# We start free, then we close a door, then open the other, then free again

var state = STATES.FREE
var is_left_open = false

export var left_open_first: bool = false

func _ready():
	if left_open_first:
		left_door.rotation_degrees = 90
		is_left_open = true
	else:
		right_door.rotation_degrees = -90

	button.connect("pressed", self, "activate")
	animator.connect("animation_finished", self, "on_animation_finished")

func activate() -> void:
	if is_left_open:
		# First close the open door if it is open
		animator.play_backwards(LEFT_OPEN)
	else:
		animator.play_backwards(RIGHT_OPEN)
	print("Closing door")
	state = STATES.CLOSING
	button.set_enabled(false)

func on_animation_finished(animation):
	# If we are closing, open the correct door
	if state == STATES.CLOSING:
		if is_left_open:
			animator.play(RIGHT_OPEN)
		else:
			animator.play(LEFT_OPEN)
		state = STATES.OPENING
		print("Now opening door")
	elif state == STATES.OPENING:
		print("Door open. Resting.")
		state = STATES.FREE
		button.set_enabled(true)
		is_left_open = !is_left_open
