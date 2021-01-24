extends Control

onready var bulb: TextureRect = get_node("HBoxContainer/Control/Bulb")
onready var door: TextureRect = get_node("HBoxContainer/Control/Door")
onready var torch: TextureRect = get_node("HBoxContainer/Control/Torch")
onready var text: Label = get_node("HBoxContainer/Label")

enum Tasks {BULB=0, DOOR=1, LEAK=2}

var current: int = 0
var max_amount: int

func set_task(task: int):
	var task_map = {
		0: bulb,
		1: door,
		2: torch
	}
	
	for i in task_map:
		task_map[i].visible = false
	
	task_map[task].visible = true

func set_progress(amount: int):
	current = amount
	text.text = '%s / %s' % [current, max_amount]
	
func is_complete() -> bool:
	return current >= max_amount
