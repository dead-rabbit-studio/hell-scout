extends Node

signal interaction
signal interaction_state_changed(is_interactable: bool)

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
	interaction_state_changed.emit(true)
	
func _on_body_exited(body: Node2D) -> void:
	var player = body as Player
	if player == null:
		return
		
	can_interact = false
	interaction_state_changed.emit(false)
