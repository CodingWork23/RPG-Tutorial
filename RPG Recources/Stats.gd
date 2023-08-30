extends Node

export(int) var max_health = 1
onready var health = max_health setget set_health	#setget --> wenn wert sich verändert, 
													#dann set_health(value) ausführen

signal no_health
signal health_changed(value)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
	print(health)
