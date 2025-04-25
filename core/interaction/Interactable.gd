extends Node

signal interaction
signal area_entered(isSomethingInside: bool)

var can_interact: bool = false
@export var is_blocked: bool = false
@onready var info_label: Label = $Info
		
func interact():
	if can_interact && !is_blocked:
		interaction.emit()
		
func _on_body_entered(_body: Player) -> void:
	print_debug("Player can interact")
	can_interact = true
	area_entered.emit(true)
	
func _on_body_exited(_body: Player) -> void:
	area_entered.emit(false)
