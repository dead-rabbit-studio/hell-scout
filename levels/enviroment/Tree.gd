extends Node2D

@onready var info_label: Label = $InfoLabel
@onready var collectable: Collectable = $Collectable

func _on_interactable_interaction() -> void:
	collectable.collect()

func _on_player_object_collected() -> void:
	queue_free()

func _on_interactable_area_entered(isSomethingInside:bool) -> void:
	info_label.visible = isSomethingInside
