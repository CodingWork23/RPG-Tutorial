extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health	#setget --> wenn wert sich verändert, 
													#dann set_health(value) ausführen

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	health = min(health, max_health)
	emit_signal("health_changed", health)
	
	if health <= 0:
		emit_signal("no_health")
	
func _ready():
	health = max_health
