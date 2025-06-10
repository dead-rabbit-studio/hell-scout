extends Node

signal interaction
signal area_entered(isSomethingInside: bool)

var can_interact: bool = false
@export var is_blocked: bool = false
		
func interact():
	if can_interact && !is_blocked:
		interaction.emit()
		
func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if player == null:
		return
		
	print_debug("Player can interact")
	can_interact = true
	area_entered.emit(true)
	
func _on_body_exited(body: Node2D) -> void:
	var player = body as Player
	if player == null:
		return
		
	can_interact = false
	area_entered.emit(false)
