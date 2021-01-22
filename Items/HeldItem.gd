extends Sprite

class_name HeldItem

var original: RigidBody2D
var astronaut: RigidBody2D

func _ready():
	pass

func initialize(item, astronaut):
	self.astronaut = astronaut
	self.original = item
	self.texture = item.get_sprite_texture()
	astronaut.add_child(self)
	astronaut.move_child(self, 0)
	self.transform = astronaut.get_mount_transform()

func finish_interaction():
	original.set_collidable(true)
	original.transform = self.global_transform
	original.angular_velocity = astronaut.angular_velocity
	original.linear_velocity = astronaut.linear_velocity
	original.visible = true
	
	self.queue_free()
