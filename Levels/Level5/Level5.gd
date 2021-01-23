extends Node2D

onready var airlock = get_node("Ship/BreakableAirLock")

func _ready():
	airlock.break_door(BreakableAirLock.Door.RIGHT)
