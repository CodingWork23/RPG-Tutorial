extends Area2D


var enemie = null

func can_see_enemie():
	return enemie != null

func _on_Collision_body_entered(body):
	enemie = body


func _on_Collision_body_exited(body):
	enemie = null
