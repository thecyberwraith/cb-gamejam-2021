extends GridContainer

const LevelButton: PackedScene = preload("res://Menus/LevelButton.tscn")

onready var back_button: Button = get_node("../BackButton")

const LEVELS_LIST: Array = [
	[ 'Repair that Bulb', 'res://Levels/Level1/Level1.tscn'],
	[ 'Think Fast', 'res://Levels/Level2/Level2.tscn'],
	[ 'Who drew the short straw?', 'res://Levels/Level3/Level3.tscn'],
	[ 'Just stay fixed!', 'res://Levels/Level4/Level4.tscn'],
	[ 'Where is the air going?', 'res://Levels/Level5/Level5.tscn'],
	[ 'Nothing is Broken!', 'res://Levels/Level6/Level6.tscn'],
	[ 'Stupid bulbs...', 'res://Levels/Level7/Level7.tscn']
]
const MainMenu = "res://Menus/MainMenu.tscn"

func _ready():
	back_button.connect("pressed", get_tree(), "change_scene", [MainMenu])
	
	for i in len(LEVELS_LIST):
		var name = LEVELS_LIST[i][0]
		var scene = LEVELS_LIST[i][1]
		
		var button = LevelButton.instance()
		add_child(button)
		button.populate(scene, i+1, name, -1)
		button.connect("play_level", get_tree(), "change_scene", [scene])
		

