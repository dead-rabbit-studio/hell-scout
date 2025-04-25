class_name Collectable
extends Node2D

signal collected

@export var is_collected = false

func collect() -> void:
	if !is_collected:
		is_collected = true
		collected.emit()