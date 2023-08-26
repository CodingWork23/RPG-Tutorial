extends KinematicBody2D

var knockback = Vector2.ZERO
export var knockbackPower = 120
onready var stats = $Stats

const DeathEffect = preload("res://RPG Recources/Effects/DeathEffect.tscn")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * knockbackPower
	
func create_deathEffect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position

func _on_Stats_no_health():
	create_deathEffect()
	queue_free()
