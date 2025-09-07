extends RigidBody2D

signal satiety_change(delta: int)

@export var satiety := 3
@export var pulse_count_to_drain_satiety := 3

var pulse_count := 0

var colleen_has_wand := false

@onready var stop_wall_penetration_shape: CollisionShape2D = $StopWallPenetrationCollisionShape2D

@onready var pulse_on_timer: Timer = %PulseOnTimer
@onready var pulse_off_timer: Timer = %PulseOffTimer
@onready var pulse_area: Area2D = %PulseArea

func _ready() -> void:
	self.satiety_change.connect(_on_wand_satiety_change)
	%PulseArea.body_entered.connect(_on_wand_body_entered_pulse_area)


func _on_colleen_player_has_wand_change(has_wand: bool) -> void:
	colleen_has_wand = has_wand
	if has_wand:
		pulse_count = 0
		self.freeze = true
		self.hide()
		pulse_on_timer.stop()
	else:
		# positive 1 indicates facing right; -1 indicates facing left
		var player_x_facing = - (%Colleen/AnimatedSprite2D.scale.x
		/ abs(%Colleen/AnimatedSprite2D.scale.x))

		# Spawn away from player in direction player is facing
		# We offset from Colleen's origin by 1 so
		# look_at works correctly
		self.position = Vector2(%Colleen.position.x + player_x_facing,
		%Colleen.position.y)

		stop_wall_penetration_shape.disabled = false
		self.freeze = false
		self.look_at(%Colleen.position)
		self.rotate(1 * PI)
		apply_central_impulse(Vector2(player_x_facing * 200 + %Colleen.velocity.x,
		-150 + %Colleen.velocity.y))

		self.show()

		pulse_on_timer.start()

func _on_pulse_on_timer_timeout() -> void:
	print('PULSE')
	%Pulse.show()
	pulse_area.monitoring = true
	pulse_count += 1
	pulse_off_timer.start()
	if pulse_count % pulse_count_to_drain_satiety == 0:
		_on_wand_satiety_change(-1)

func _on_pulse_off_timer_timeout() -> void:
	print('pulse off')
	%Pulse.hide()
	pulse_area.monitoring = false
	pulse_on_timer.start()

func _on_wand_body_entered_pulse_area(body: Node2D):
	var health_component: HealthComponent = body.get_node('HealthComponent')
	if (health_component):
		health_component.try_health_change.emit(-1)

func _on_wand_satiety_change(delta: int):
	satiety += delta
	%WandSatietyLabel.text = str(satiety)
