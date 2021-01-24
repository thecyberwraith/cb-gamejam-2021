extends Node2D

class_name TimedBulbBase

signal net_bulb_change

export var duration: float = 3

onready var base: BulbBase = get_node("BulbBase")
onready var timer: Timer = get_node("Timer")
onready var progress: ProgressBar = get_node("ProgressBar")

func _ready():
	base.connect("on_bulb_placed", self, "start_countdown")
	base.connect("on_bulb_removed", self, "cancel_timer")
	timer.connect("timeout", self, "perform_ejection")
	progress.max_value = duration
	timer.wait_time = duration

func _process(_delta):
	progress.value = timer.time_left

func start_countdown():
	emit_signal("net_bulb_change", 1)
	progress.visible = true
	progress.value = duration
	timer.start(duration)

func perform_ejection():
	base.eject_bulb()
	emit_signal("net_bulb_change", -1)
	progress.visible = false

func cancel_timer():
	emit_signal("net_bulb_change", -1)
	progress.visible = false
	timer.stop()
