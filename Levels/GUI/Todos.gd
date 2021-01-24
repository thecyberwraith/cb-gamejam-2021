extends Control

class_name Todos

signal all_tasks_complete

const TaskItem = preload("res://Levels/GUI/TaskItem.tscn")

onready var container = get_node("PanelContainer/HBoxContainer/Container")

enum Tasks {BULB=0, DOOR=1, LEAK=2}

var current_tasks: Dictionary = {}

func add_todo(task: int, max_amount: int, start: int = 0):
	print('Adding task.')
	if not task in current_tasks:
		var new_task = TaskItem.instance()
		container.add_child(new_task)
		new_task.set_task(task)
		new_task.max_amount = max_amount
		new_task.set_progress(start)
		current_tasks[task] = new_task
	visible = true

func update_todo(task: int, amount: int):
	current_tasks[task].set_progress(amount)
	
	for task in current_tasks:
		if !current_tasks[task].is_complete():
			return

	emit_signal("all_tasks_complete")
