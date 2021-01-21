extends Camera2D

onready var astro = get_node("../Astronaut")

func _ready():
	astro.add_to_group('player')
	
func _process(_delta):
	var players = get_tree().get_nodes_in_group('player')
	
	if len(players) > 0:
		self.position = players[0].position
