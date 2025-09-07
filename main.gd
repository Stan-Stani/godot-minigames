extends Node2D

func _notification(what: int):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		print("focus out!")
		get_tree().paused = true
	if what == NOTIFICATION_WM_WINDOW_FOCUS_IN:
		get_tree().paused = false
