extends RigidBody2D

class_name Item

onready var sprite: Sprite = get_node("Sprite")
onready var collider: CollisionShape2D = get_node("CollisionShape2D")

var stored_collision_mask: int
var stored_collision_layer: int

const HeldItem = preload("res://Items/HeldItem.tscn")

func _ready():
	print('Collisions stored')
	stored_collision_mask = collision_mask

func interact(astronaut) -> HeldItem:
	set_collidable(false)
	var item = HeldItem.instance()
	item.initialize(self, astronaut)
	self.visible = false
	return item
	
func get_sprite_texture() -> Texture:
	return sprite.texture

func set_collidable(collide: bool) -> void:
	print('Setting collisions to ', collide)
	collider.set_deferred("disabled", !collide)
	#if collide:
	#	collision_mask = stored_collision_mask
	#	collision_layer = stored_collision_layer
	#else:
	#	collision_mask = 0
	#	collision_layer = 0
