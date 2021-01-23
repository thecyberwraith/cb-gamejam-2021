extends Node2D

const AirLeak: PackedScene = preload("res://Levels/Interactables/AirLeak/AirLeakScene.tscn")

onready var asteroid: Asteroid = get_node("Asteroid")
onready var level_core: LevelCore = get_node("LevelCore")

var leak_created:bool = false

func _ready():
	asteroid.connect("collision", self, "asteroid_contact")

func _process(_delta):
	if leak_created and len(get_tree().get_nodes_in_group('leaks')) == 0:
		level_core.level_success()

func asteroid_contact(state: Physics2DTestMotionResult):
	var leak = AirLeak.instance()
	leak.position = state.collision_point
	leak.rotation = (-1*state.collision_normal).angle()
	call_deferred("add_child", leak)
	leak_created = true
