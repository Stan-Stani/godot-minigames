extends Node2D

var wand_original_parent = Node2D
func _on_colleen_pickup_wand_toggle() -> void:
	if self.get_parent() != %Colleen:
		wand_original_parent = self.get_parent()
		self.reparent(%Colleen)
		self.freeze = true
	else:
		self.reparent(wand_original_parent)
		self.freeze = false
