extends Node2D

func create_grassEffect():
	var GrassEffect = load("res://RPG Recources/Effects/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance() #instance() --> Node erstellen
	var world = get_tree().current_scene #get_tree() --> root	#current_scene --> der erste Node im root
	world.add_child(grassEffect)
	grassEffect.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grassEffect()
	queue_free()
