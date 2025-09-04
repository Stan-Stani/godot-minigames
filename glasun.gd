extends CharacterBody2D
var move: bool = true

@onready var colleen: CharacterBody2D = %Colleen

func _physics_process(delta: float) -> void:
	if move:
		if round(colleen.position.x) > round(self.position.x):
			self.position.x += delta * 5
		elif round(colleen.position.x) < round(self.position.y):
			self.position.x -= delta * 5


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == %Colleen:
		EventBus.player_health_change.emit(-1)
		move = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	print('exit')
	if body == %Colleen:
		move = true
