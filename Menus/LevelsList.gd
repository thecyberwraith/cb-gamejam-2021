extends GridContainer

onready var back_button: Button = get_node("../BackButton")

const LEVELS_LIST: Array = [
	[ 'Repair that Bulb', 'res://Levels/Level1/Level1.tscn'],
	[ 'Think Fast', 'res://Levels/Level2/Level2.tscn'],
	[ 'Who drew the short straw?', 'res://Levels/Level3/Level3.tscn'],
	[ 'Just stay fixed!', 'res://Levels/Level4/Level4.tscn']
]
const MainMenu = "res://Menus/MainMenu.tscn"

func _ready():
	back_button.connect("pressed", get_tree(), "change_scene", [MainMenu])
	
	for level_info in LEVELS_LIST:
		var name = level_info[0]
		var scene = level_info[1]
		
		var button = Button.new()
		button.text = name
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		button.connect("pressed", get_tree(), "change_scene", [scene])
		
		add_child(button)
