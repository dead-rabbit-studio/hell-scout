extends Node2D

@onready var info_label: Label = $InfoLabel

func _on_interactable_interaction() -> void:
	print_debug("Player interacted with the tree")
	queue_free()


func _on_interactable_on_interaction_area(isSomethingInside: bool) -> void:
	info_label.visible = isSomethingInside
