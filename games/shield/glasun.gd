extends CharacterBody2D
var move: bool = true
var facing: String = 'left'

var bounce_bolt_timer_done := false

var bounce_bolt = preload("res://games/shield/bounceBolt.tscn")
@onready var dehd: CharacterBody2D = %Dehd
@onready var bounce_bolt_timer: Timer = %TimerBounceBolt

func _physics_process(_delta: float) -> void:
	if move:
		if round(dehd.position.x) > round(self.position.x):
			self.velocity.x = 5
			facing = 'right'
		elif round(dehd.position.x) < round(self.position.x):
			self.velocity.x = -5
			facing = 'left'

	var overlapping_bodies = %SeekArea.get_overlapping_bodies()
	var closest_body: Node2D = null
	# print(overlapping_bodies)
	if bounce_bolt_timer.is_stopped():
		for body in overlapping_bodies:
			if body == %Dehd:
				var a_bounce_bolt: RigidBody2D = bounce_bolt.instantiate()
				a_bounce_bolt.position = self.position
				var unit_vector_to_target = self.position.direction_to(body.position)
				a_bounce_bolt.apply_central_impulse(unit_vector_to_target * 900)
				$"/root/Main".add_child(a_bounce_bolt)
				bounce_bolt_timer.start()


	if facing == 'right':
		self.transform.x = Vector2(-1.0, 0.0)
	elif facing == 'left':
		self.transform.x = Vector2(1.0, 0.0)

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == %Colleen:
		body.get_node("HealthComponent").try_health_change.emit(-1)


func _on_area_2d_body_exited(_body: Node2D) -> void:
	print('exit')
