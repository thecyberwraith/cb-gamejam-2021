extends GridContainer

const LevelButton: PackedScene = preload("res://Menus/LevelButton.tscn")

onready var back_button: Button = get_node("../BackButton")

const MainMenu = "res://Menus/MainMenu.tscn"

func _ready():
	back_button.connect("pressed", get_tree(), "change_scene", [MainMenu])
	var save: SaveFile = SaveFile.new()
	
	for i in len(Levels.array):
		var button = LevelButton.instance()
		add_child(button)
		
		if save.is_level_unlocked(i):
			var name = Levels.array[i][0]
			var scene = Levels.array[i][1]
			var best = save.get_level_best_time(i)
			button.populate(scene, i, name, best)
			
		button.connect("play_level", get_tree(), "change_scene")
