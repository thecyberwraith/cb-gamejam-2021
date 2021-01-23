extends Node2D

onready var level_core: LevelCore = get_node("LevelCore")
onready var airlock: BreakableAirLock = get_node("Ship/BreakableAirLock")
onready var base: BulbBase = get_node("BulbBase")

var door_ejected_before: bool = false

func _ready():
	airlock.connect("door_attached", self, "on_door_repaired")
	base.connect("on_bulb_placed", self, "on_bulb_placed")

func on_door_repaired():
	door_ejected_before = true
	if base.bulb_placed:
		base.eject_bulb()

func on_bulb_placed():
	if door_ejected_before and airlock.broken_door == airlock.Door.NONE:
		level_core.level_success()
	else:
		airlock.break_door(BreakableAirLock.Door.LEFT)
		door_ejected_before = true

