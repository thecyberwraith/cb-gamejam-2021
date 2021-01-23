extends Node2D

onready var level_core = get_node("LevelCore")
onready var base_1 = get_node("BulbBase")
onready var base_2 = get_node("BulbBase2")

var bases_filled = 0

func _ready():
	for base in [base_1, base_2]:
		base.connect("on_bulb_placed", self, "change_bulb_count", [1])
		base.connect("on_bulb_removed", self, "change_bulb_count", [-1])
	
func change_bulb_count(amt: int):
	bases_filled += amt
	
	if bases_filled == 2:
		level_core.level_success()
