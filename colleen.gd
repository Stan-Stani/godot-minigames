extends CharacterBody2D

signal player_has_wand_change(has_wand: bool)


@export var speed_base = 100
@export var gravity = 200
@export var jump_force_base = 150
@export var health = 3


var speed = speed_base
var jump_force = jump_force_base

var was_just_in_air: bool = true
var has_wand: bool = false
var is_wand_in_pickup_range = false


func _ready() -> void:
	EventBus.player_health_change.connect(_on_player_health_change)
	%HealthValueLabel.text = str(health)

func _process(_delta: float) -> void:
	if self.is_on_floor():
		if (Input.is_action_pressed("ui_right")
			|| Input.is_action_pressed("ui_left")):
				$AnimatedSprite2D.play('walk' if !has_wand else 'walk_with_wand')
		elif !was_just_in_air && $AnimatedSprite2D.animation != 'jump':
			if !has_wand:
				$AnimatedSprite2D.play('idle')
			else:
				$AnimatedSprite2D.play('idle_with_wand')

	if Input.is_action_just_pressed("pickup_toggle"):
		handle_try_wand_pickup_toggle()


func _physics_process(delta):
	velocity.y += gravity * delta
	handle_horizontal_input()
	handle_land()
	handle_jump_input()
	move_and_slide()

	handle_colleen_wandless()


func handle_horizontal_input():
	var horizontal_input: float = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	velocity.x = horizontal_input * speed

	if horizontal_input > 0:
		$AnimatedSprite2D.scale.x = -1
	elif horizontal_input < 0:
		$AnimatedSprite2D.scale.x = 1

func handle_jump_input():
	var jump_input: float = - (
		Input.get_action_strength("ui_select") if Input.get_action_strength("ui_select") != 0
		else Input.get_action_strength("ui_up")
	)

	if (jump_input && self.is_on_floor()):
		velocity.y = jump_input * jump_force
		if jump_input != 0:
			was_just_in_air = true
			$AnimatedSprite2D.play('jump', 2)


func handle_try_wand_pickup_toggle():
	if !has_wand && is_wand_in_pickup_range:
		has_wand = true
		player_has_wand_change.emit(true)
	elif has_wand:
		has_wand = false
		player_has_wand_change.emit(false)


func handle_land():
	if !self.is_on_floor():
		was_just_in_air = true
	if was_just_in_air && self.is_on_floor():
		$AnimatedSprite2D.play('jump')
		was_just_in_air = false

func handle_colleen_wandless():
	if !has_wand:
		speed = speed_base * 1.5
		jump_force = jump_force_base * 1.23
	else:
		speed = speed_base
		jump_force = jump_force_base
	# print(distance, jump_force_base, speed_base)

func _on_player_health_change(delta: int):
	print("delta health ", delta)
	health += delta
	%HealthValueLabel.text = str(health)

	if health <= 0:
		get_tree().reload_current_scene()


func _on_wand_pickup_zone_body_entered(body: Node2D) -> void:
	print('hey')
	if body == self:
		is_wand_in_pickup_range = true
		print('hey')


func _on_wand_pickup_zone_body_exited(body: Node2D) -> void:
	if body == self:
		is_wand_in_pickup_range = false