extends "res://Items/ConstantlyInteractable.gd"

class_name HeldItem

onready var sprite = get_node("Sprite")

var original
var astronaut

func _ready():
	sprite.texture = original.get_sprite_texture()
	
func initialize(held_descriptor, item, a_astronaut):
	astronaut = a_astronaut
	original = item
	
	astronaut.add_child(self)
	astronaut.move_child(self, 0)
	
	transform = astronaut.get_mount_transform()
	descriptor = held_descriptor

func finish_interaction():
	original.set_active(true)
	original.transform = self.global_transform
	original.angular_velocity = astronaut.angular_velocity
	original.linear_velocity = astronaut.linear_velocity
	original.visible = true
	
	self.queue_free()
