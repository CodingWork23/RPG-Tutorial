extends KinematicBody2D

var knockback = Vector2.ZERO
export var knockbackPower = 120
onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * knockbackPower
	stats.health -= area.stats.damage