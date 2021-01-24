extends Node2D

class_name TimedBulbBase

export var duration: float = 3

onready var base: BulbBase = get_node("BulbBase")
onready var timer: Timer = get_node("Timer")
onready var progress: ProgressBar = get_node("ProgressBar")

signal net_bulb_placed

func _ready():
	base.connect("on_bulb_placed", self, "start_countdown")
	base.connect("on_bulb_removed", self, "cancel_timer")
	base.connect("net_bulb_placed", self, "propagate_signal")
	timer.connect("timeout", self, "perform_ejection")
	progress.max_value = duration
	timer.wait_time = duration

func _process(_delta):
	progress.value = timer.time_left

func propagate_signal(change: int):
	emit_signal("net_bulb_placed", change)

func start_countdown():
	progress.visible = true
	progress.value = duration
	timer.start(duration)

func perform_ejection():
	base.eject_bulb()
	progress.visible = false

func cancel_timer():
	progress.visible = false
	timer.stop()
