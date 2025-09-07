class_name HealthComponent
extends Node

signal try_health_change(delta: int)

@export var health := 1

@onready var wand = $"/root/Main".get_node("%Wand")

func _ready() -> void:
	try_health_change.connect(_on_try_health_change)

func _on_try_health_change(delta: int):
	health += delta
	print(get_parent(), health, ' health')
	wand.satiety_change.emit(-delta)

	if health <= 0:
		self.owner.free()
