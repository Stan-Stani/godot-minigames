extends RigidBody2D

var colleen_has_wand := false

@onready var stop_wall_penetration_shape: CollisionShape2D = $StopWallPenetrationCollisionShape2D

@onready var pulse_timer: Timer = %PulseTimer


func _on_colleen_player_has_wand_change(has_wand: bool) -> void:
	colleen_has_wand = has_wand
	if has_wand:
		self.freeze = true
		self.hide()
		pulse_timer.stop()
	else:
		# positive 1 indicates facing right; -1 indicates facing left
		var player_x_facing = - (%Colleen/AnimatedSprite2D.scale.x
		/ abs(%Colleen/AnimatedSprite2D.scale.x))

		# Spawn away from player in direction player is facing
		# We the offset from Colleen's origin by 1 so
		# look_at works correctly
		self.position = Vector2(%Colleen.position.x + player_x_facing,
		%Colleen.position.y)

		stop_wall_penetration_shape.disabled = false
		self.freeze = false
		self.look_at(%Colleen.position)
		self.rotate(1 * PI)
		apply_central_impulse(Vector2(player_x_facing * 200, -150))

		self.show()

		pulse_timer.start()


func _on_pulse_timer_timeout() -> void:
	print('PULSE')
	%Pulse.visible = !%Pulse.visible
