extends CharacterBody2D

@export var gravity = 200


var move: bool = true
var facing: String = 'left'

@onready var colleen: CharacterBody2D = %Colleen

@onready var pulse_area: Area2D = %PulseArea

func _ready() -> void:
	pulse_area.body_entered.connect(_on_wand_pulse_body_entered)

func _on_wand_pulse_body_entered(body: Node2D):
	print(body)
	if body == self:
		print('wow comet u dead')

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta


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
		EventBus.player_health_change.emit(-1)
		# move = false


func _on_area_2d_body_exited(_body: Node2D) -> void:
	print('exit')
