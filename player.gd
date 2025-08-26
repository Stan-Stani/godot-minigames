extends CharacterBody2D

@export var speed = 100
@export var gravity = 200


func _physics_process(delta):
	velocity.y += gravity * delta
	handle_horizontal_input()
	move_and_slide()


func handle_horizontal_input():
	var horizontal_input: float = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	velocity.x = horizontal_input * speed
