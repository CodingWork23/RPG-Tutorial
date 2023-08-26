extends Area2D

var player = null


func can_see_player():
	return player != null

func _on_AreaDetectionZone_body_entered(body):
	player = body


func _on_AreaDetectionZone_body_exited(body):
	player = null
