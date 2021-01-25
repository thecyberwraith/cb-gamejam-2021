extends Node2D

const AirLeak: PackedScene = preload("res://Levels/Interactables/AirLeak/AirLeakScene.tscn")
const Asteroid: PackedScene = preload("res://Levels/Hazards/Asteroid/AsteroidScene.tscn")

onready var level_core: LevelCore = get_node("LevelCore")
onready var todos: Todos = level_core.get_todos()
onready var ship: TileMap = get_node("TileMap")

onready var button: InteractableButton = get_node("TileMap/Button")
onready var hidden: Node2D = get_node("HiddenObjectives")
onready var airlock: BreakableAirLock = get_node("TileMap/BreakableAirLock")
onready var base: TimedBulbBase = get_node("HiddenObjectives/TimedBulbBase")
onready var timer: Timer = get_node("Timer")

var asteroids: Array = []
var leak_total: int = 1

func _ready():
	button.connect("pressed", self, "begin_the_fun")

func begin_the_fun():
	button.set_enabled(false)
	
	todos.add_todo(Todos.Tasks.BULB, 1)
	todos.add_todo(Todos.Tasks.DOOR, 1)
	todos.add_todo(Todos.Tasks.LEAK, 1)
	
	hidden.visible = true
	ship.set_cell(0,-1, 1)
	
	base.connect("net_bulb_placed", self, "bulb_popped")
	
	airlock.break_door(BreakableAirLock.Door.LEFT)
	airlock.connect("door_attached", todos, "delta_todo_progress", [Todos.Tasks.DOOR, 1])
	
	var leak = AirLeak.instance()
	add_child(leak)
	leak.position.x = 512
	leak.position.y = 0
	leak.rotation_degrees = 90
	leak.connect("patched", todos, "delta_todo_progress", [Todos.Tasks.LEAK, 1])
	
	todos.connect("all_tasks_complete", level_core, "level_success")
	
	timer.connect("timeout", self, "make_asteroid")
	timer.start()

func bulb_popped(amount: int):
	todos.delta_todo_progress(Todos.Tasks.BULB, amount)
	
	if amount == -1:
		airlock.break_door(BreakableAirLock.Door.RIGHT)
		todos.delta_todo_progress(Todos.Tasks.DOOR, -1)

func make_asteroid():
	var asteroid = Asteroid.instance()
	asteroid.connect("collision", self, "make_leak")
	asteroid.position = Vector2(1024, -512)
	asteroid.linear_velocity = Vector2(-100, 100)
	asteroid.angular_velocity = rand_range(4, 10)
	add_child(asteroid)
	
	if len(asteroids) > 3:
		asteroids.pop_front().queue_free()
	
	asteroids.append(asteroid)

func make_leak(state: Physics2DTestMotionResult):
	var leak = AirLeak.instance()
	leak.position = state.collision_point
	leak.rotation = (-1*state.collision_normal).angle() - (PI/2)
	call_deferred("add_child", leak)
	
	leak.connect("patched", todos, "delta_todo_progress", [Todos.Tasks.LEAK, 1])

	leak_total += 1	
	todos.get_todo(Todos.Tasks.LEAK).max_amount = leak_total
	todos.delta_todo_progress(Todos.Tasks.LEAK, 0)
