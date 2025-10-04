extends Node2D



func _ready() -> void:
	if OS.is_debug_build():
			get_tree().change_scene_to_file("res://mainShield.tscn")




func _on_shield_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainShield.tscn")


func _on_colleen_button_pressed() -> void:
	get_tree().change_scene_to_file("res://games/colleen/mainColleen.tscn")

