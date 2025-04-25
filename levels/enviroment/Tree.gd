extends Node2D

@onready var info_label: Label = $InfoLabel
@onready var player_area: CollisionShape2D = $PlayerArea/CollisionShape2D
@onready var collectable: Collectable = $Collectable

func _on_interactable_interaction() -> void:
	collectable.collect()

func _on_interactable_on_interaction_area(isSomethingInside: bool) -> void:
	info_label.visible = isSomethingInside

func _on_player_object_collected() -> void:
	queue_free()
