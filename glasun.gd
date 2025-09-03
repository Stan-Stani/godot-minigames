extends StaticBody2D

@onready var colleen: CharacterBody2D = %Colleen

func _physics_process(delta: float) -> void:
	if colleen.position.x > self.position.x:
		print('go right')
		self.position.x += delta * 5
	elif colleen.position.x < self.position.y:
		print('go left')
		self.position.x -= delta * 5
