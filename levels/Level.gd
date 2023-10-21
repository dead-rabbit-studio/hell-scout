extends Node2D

func _on_gun_gun_was_fired(bullet: RigidBody2D) -> void:
	add_child(bullet)
