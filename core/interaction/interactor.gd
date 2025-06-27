class_name Interactor
extends Node

signal interacted

@export var is_enabled = false

func interact():
	if is_enabled:
		interacted.emit()