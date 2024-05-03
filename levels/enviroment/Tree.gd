extends Node2D

func _on_interactable_interaction() -> void:
	print_debug("Player interacted with the tree")
	queue_free()
