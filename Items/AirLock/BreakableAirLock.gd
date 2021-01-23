extends AirLock

class_name BreakableAirLock

const AirLockDoorItem: PackedScene = preload("res://Items/AirLock/AirLockDoorItem.tscn")
onready var area: InteractableAirLockDoorRepair = get_node("InteractableAirLockDoorRepair")

enum Door {LEFT, RIGHT, NONE}

signal door_detached
signal door_attached

var broken_door: int = Door.NONE

func _ready():
	area.set_interactable(false)
	area.connect("repair_made", self, "on_door_repaired")
	
func break_door(door):
	if broken_door != Door.NONE:
		print('I am already broken...')
		return

	var door_obj = left_door
	if door == Door.RIGHT:
		door_obj = right_door
	
	door_obj.visible = false
	door_obj.get_node("CollisionShape2D").disabled = true
	area.position = door_obj.position
	
	var door_item = AirLockDoorItem.instance()
	door_item.transform = door_obj.transform
	var random = RandomNumberGenerator.new()
	random.randomize()
	door_item.angular_velocity = random.randf_range(-3, 3)
	door_item.linear_velocity.x = random.randf_range(-13, 13)
	door_item.linear_velocity.y = random.randf_range(-13, 13)
	add_child(door_item)
	
	print('Breaking the door!')
	area.set_interactable(true)
	button.set_enabled(false)

	emit_signal("door_detached")
	broken_door = door
	
func on_door_repaired():
	var door_obj = left_door
	if broken_door == Door.RIGHT:
		door_obj = right_door
	door_obj.visible = true
	door_obj.get_node("CollisionShape2D").disabled = false
	print('Door repaired!')
	emit_signal("door_attached")
	area.set_interactable(false)
	button.set_enabled(true)
	broken_door = Door.NONE
