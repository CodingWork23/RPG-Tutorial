extends Control

var hearts = 1 setget set_hearts
var max_hearts = 1 setget set_max_hearts

onready var label = $Label

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)

func set_max_hearts(value):
	max_hearts = max(value, 1)

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")
	print(PlayerStats.is_connected("health_changed", self, "set_hearts"))
