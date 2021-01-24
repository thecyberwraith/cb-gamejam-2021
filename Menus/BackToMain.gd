extends Button

func _ready():
	connect("pressed", get_tree(), "change_scene", ["res://Menus/MainMenu.tscn"])
