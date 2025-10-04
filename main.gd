extends Node2D


const START_SECONDS := 100.0






func _on_shield_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainShield.tscn")


func _on_colleen_button_pressed() -> void:
	get_tree().change_scene_to_file("res://games/colleen/mainColleen.tscn")

