class_name Interactor
extends Node2D

signal interacted

func interact():
	interacted.emit()