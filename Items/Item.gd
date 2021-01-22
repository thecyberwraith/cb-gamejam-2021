
extends RigidBody2D

class_name Item

onready var sprite: Sprite = get_node("Sprite")
onready var collider: CollisionShape2D = get_node("CollisionShape2D")
onready var interactions: ItemInteractableArea = get_node("ItemInteractableArea")

const HeldItem = preload("res://Items/HeldItem.tscn")

func _ready():
	interactions.initialize(self)

func get_sprite_texture() -> Texture:
	return sprite.texture

func set_active(active: bool) -> void:
	print('Setting active to ', active)
	collider.set_deferred("disabled", !active)
	interactions.set_interactable(active)
	visible = active

func get_held_descriptor():
	return interactions.held_descriptor
