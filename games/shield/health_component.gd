class_name HealthComponent_Shield
extends Node

# cause is optional
signal try_health_change(delta: int, cause: Node)

@export var health := 1

@onready var wand = $"/root/Main".get_node("%Wand")

func _ready() -> void:
	try_health_change.connect(_on_try_health_change)

func _on_try_health_change(delta: int, cause: Node = null):
	health += delta
	print(get_parent(), health, ' health')

	if cause == wand:
		wand.satiety_change.emit(-delta)

	if self.owner == $"/root/Main/%Colleen":
		$"/root/Main/%HealthValueLabel".text = str(health)
		if health <= 0:
			get_tree().reload_current_scene()
	else:
		if health <= 0:
			self.owner.free()
