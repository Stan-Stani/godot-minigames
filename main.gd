extends Node2D

const START_SECONDS := 100.0
var seconds_remaining := START_SECONDS
var time_elapsed := 0.0
var has_won := false


func _notification(what: int):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		print("focus out!")
		get_tree().paused = true
	if what == NOTIFICATION_WM_WINDOW_FOCUS_IN:
		get_tree().paused = false


func _process(delta: float) -> void:
	var null_if_enemies_dead = get_tree().get_first_node_in_group("enemy")
	if null_if_enemies_dead == null:
		has_won = true
	time_elapsed += delta
	if (!has_won):
		seconds_remaining = START_SECONDS - (time_elapsed)

		%TimerLabel/Time.text = str(int(seconds_remaining))
		if seconds_remaining < 0:
			%Colleen.get_node("HealthComponent").try_health_change.emit(-1000)
	else:
		$"/root/Main/%CenterLabel".text = "YOU WIN!"
