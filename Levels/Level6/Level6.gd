extends Node2D

const AirLeak: PackedScene = preload("res://Levels/Interactables/AirLeak/AirLeakScene.tscn")

onready var level_core: LevelCore = get_node("LevelCore")
onready var todos: Todos = level_core.get_todos()

var leak_created:bool = false

func _ready():
	for asteroid in get_tree().get_nodes_in_group('asteroids'):
		asteroid.connect("collision", self, "asteroid_contact")
	
	todos.connect("all_tasks_complete", level_core, "level_success")

func asteroid_contact(state: Physics2DTestMotionResult):
	if !leak_created:
		leak_created = true
		todos.add_todo(Todos.Tasks.LEAK, 0)
		
	var leak = AirLeak.instance()
	leak.position = state.collision_point
	leak.rotation = (-1*state.collision_normal).angle() - (PI/2)
	call_deferred("add_child", leak)
	
	leak.connect("patched", todos, "delta_todo_progress", [Todos.Tasks.LEAK, 1])
	# The +1 is because we defer adding the child
	todos.get_todo(Todos.Tasks.LEAK).max_amount = len(get_tree().get_nodes_in_group('leaks')) + 1
	todos.delta_todo_progress(Todos.Tasks.LEAK, 0)
