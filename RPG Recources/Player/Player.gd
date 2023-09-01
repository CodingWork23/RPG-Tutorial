extends KinematicBody2D

var velocity = Vector2.ZERO


export(int) var MAX_SPEED = 75
export(int) var ACELERATION = 500
export(int) var FRICTION = 500
export(int) var ROLL_SPEED = 100

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $Position2D/SwordHitbox
onready var hurtbox = $Hurtbox

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var rollVector = Vector2.DOWN


func _ready():
	PlayerStats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = rollVector
	PlayerStats.health = PlayerStats.max_health
	
	
func _process(delta):
	
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state()
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		rollVector = input_vector  
		swordHitbox.knockback_vector = input_vector
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")

		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACELERATION * delta)
		#velocity += input_vector * ACELERATION * delta
		#velocity = velocity.limit_length(MAX_SPEED * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()
	
	if Input.is_action_just_pressed("ui_select"):
		state = ATTACK
		
	if Input.is_action_just_pressed("ctrl"):
		state = ROLL
		
	
func move():
	velocity = move_and_slide(velocity)

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE
	
func roll_state():
	PlayerStats.health += 1
	animationState.travel("Roll")
	velocity = rollVector * ROLL_SPEED
	move()
	
func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE
	

func _on_Hurtbox_area_entered(area):
	PlayerStats.health -= area.damage
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hitEffect()


func _on_PlayerStats_no_health():
	queue_free()
