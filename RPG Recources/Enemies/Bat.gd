extends KinematicBody2D


export var knockbackPower = 120
export var MAX_SPEED = 50
export var ACCELERATION = 300
export var FRICTION = 200

onready var stats = $Stats
onready var playerDetectionZone = $AreaDetectionZone
onready var collision = $Collision
onready var animatedSprite = $AnimatedSprite
onready var hurtbox = $Hurtbox
const DeathEffect = preload("res://RPG Recources/Effects/DeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO


func _physics_process(delta):
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			soft_collision(delta)
			
		WANDER:
			pass
			
		CHASE:
			chase_player(delta)
	
	velocity = move_and_slide(velocity)
	
	if velocity.x < 0:
		animatedSprite.flip_h = true
	elif velocity.x > 0:
		animatedSprite.flip_h = false

	
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func soft_collision(delta):
	var enemie = collision.enemie
	if enemie != null:
		var soft_direction = (global_position - enemie.global_position).normalized()
		velocity = velocity.move_toward(soft_direction * MAX_SPEED, ACCELERATION * delta)
		
func chase_player(delta):
	var player = playerDetectionZone.player
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		
	else:
		state = IDLE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * knockbackPower
	hurtbox.create_hitEffect()
	
func create_deathEffect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position

func _on_Stats_no_health():
	create_deathEffect()
	queue_free()
