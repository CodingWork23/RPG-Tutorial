extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		var GrassEffect = load("res://RPG Recources/Effects/GrassEffect.tscn")
		var grassEffect = GrassEffect.instance() #instance() --> Node erstellen
		var world = get_tree().current_scene #get_tree() --> root	#current_scene --> der erste Node im root
		world.add_child(grassEffect)
		grassEffect.global_position = global_position
		queue_free()
