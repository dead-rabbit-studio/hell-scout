class_name HitBox
extends Area2D


@export var damage := 10

func _init() -> void:
	collision_layer = 2
	collision_mask = 0
