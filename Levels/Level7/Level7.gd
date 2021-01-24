extends Node2D

onready var level_core: LevelCore = get_node("LevelCore")

var bulbs_down: int = 0
onready var bulbs_needed: int = len(get_tree().get_nodes_in_group('bases'))

func _ready():
	for base in get_tree().get_nodes_in_group('bases'):
		base.connect("net_bulb_change", self, "bulb_changed")

func bulb_changed(amount: int):
	bulbs_down += amount
	if bulbs_down == bulbs_needed:
		level_core.level_success()
