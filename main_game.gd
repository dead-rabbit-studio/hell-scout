extends Node2D

func _on_gun_gun_was_fired(bullet: Node2D) -> void:
	add_child(bullet)
