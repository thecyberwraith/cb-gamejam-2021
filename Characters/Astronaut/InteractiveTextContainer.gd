extends PanelContainer

onready var label = get_node("InteractiveText")

func on_interactions(interactable: InteractableArea):
	if interactable != null:
		self.visible = true
		label.text = interactable.interact_text
	else:
		self.visible = false
