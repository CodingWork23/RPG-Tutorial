extends Area2D

const HitEffect = preload("res://RPG Recources/Effects/HitEffect.tscn")
export(bool) var show_hit = true

func create_hitEffect():
	if show_hit:
		var hitEffect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(hitEffect)
		hitEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	create_hitEffect()
