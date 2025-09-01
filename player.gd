extends CharacterBody2D

@export var speed_base = 100
@export var gravity = 200
@export var jump_force_base = 150

var speed = speed_base
var jump_force = jump_force_base

var was_just_in_air: bool = true


func _process(_delta: float) -> void:
	if self.is_on_floor():
		if (Input.is_action_pressed("ui_right")
			|| Input.is_action_pressed("ui_left")):
				$Colleen.play('walk')
		elif !was_just_in_air && $Colleen.animation != 'jump':
			$Colleen.play('idle')

func _physics_process(delta):
	velocity.y += gravity * delta
	handle_horizontal_input()
	handle_land()
	handle_jump_input()
	move_and_slide()

	handle_distance_from_wand()


func handle_horizontal_input():
	var horizontal_input: float = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	velocity.x = horizontal_input * speed

	if horizontal_input > 0:
		$Colleen.scale.x = -1
	elif horizontal_input < 0:
		$Colleen.scale.x = 1

func handle_jump_input():
	var jump_input: float = - (
		Input.get_action_strength("ui_select") if Input.get_action_strength("ui_select") != 0
		else Input.get_action_strength("ui_up")
	)

	if (jump_input && self.is_on_floor()):
		velocity.y = jump_input * jump_force
		if jump_input != 0:
			was_just_in_air = true
			$Colleen.play('jump', 2)

func handle_land():
	if !self.is_on_floor():
		was_just_in_air = true
	if was_just_in_air && self.is_on_floor():
		$Colleen.play('jump')
		was_just_in_air = false

func handle_distance_from_wand():
	var distance = self.position.distance_to($/root/Main/Wand.position)
	if distance >= 100:
		jump_force = jump_force_base + jump_force_base * (distance / 1000)
		speed = speed_base + speed_base * (distance / 1000)
	print(distance, jump_force_base, speed_base)
