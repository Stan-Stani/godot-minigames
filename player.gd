extends CharacterBody2D

@export var speed = 100
@export var gravity = 200
@export var jump_force = 150


func _physics_process(delta):
	velocity.y += gravity * delta
	handle_horizontal_input()
	handle_jump_input()
	move_and_slide()


func handle_horizontal_input():
	var horizontal_input: float = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	velocity.x = horizontal_input * speed

func handle_jump_input():
	var jump_input: float = - (
		Input.get_action_strength("ui_select")
	)

	if (jump_input && self.is_on_floor()):
		velocity.y = jump_input * jump_force
