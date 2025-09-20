extends CharacterBody2D
var move: bool = true
var facing: String = 'left'

@onready var colleen: CharacterBody2D = %Colleen

func _physics_process(_delta: float) -> void:
	if move:
		if round(colleen.position.x) > round(self.position.x):
			self.velocity.x = 5
			facing = 'right'
		elif round(colleen.position.x) < round(self.position.x):
			self.velocity.x = -5
			facing = 'left'


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
