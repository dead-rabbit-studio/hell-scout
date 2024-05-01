extends Node

signal interaction

var can_interact: bool = false

func _on_body_entered(body: Node2D) -> void:
	print_debug("Player can interact")
	can_interact = true
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('interact'):
		if can_interact:
			interaction.emit()
