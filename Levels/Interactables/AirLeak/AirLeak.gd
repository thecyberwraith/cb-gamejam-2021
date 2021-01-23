extends Node2D

class_name AirLeak

onready var particles: CPUParticles2D = get_node("CPUParticles2D")
onready var area: AirLeakInteractableArea = get_node("AirLeakInteractableArea")

signal patched

func _ready():
	area.connect("patched", self, "on_air_leak_patched")
	#add_to_group('leaks')

func on_air_leak_patched():
	emit_signal("patched")
	queue_free()
