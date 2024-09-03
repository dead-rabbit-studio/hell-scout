extends Node

signal interaction
signal on_interaction_area(isSomethingInside: bool)

var can_interact: bool = false
@export var is_blocked: bool = false
@onready var info_label: Label = $Info
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('interact'):
		if can_interact && !is_blocked:
			interaction.emit()

func _on_body_entered(_body: Player) -> void:
	print_debug("Player can interact")
	can_interact = true
	on_interaction_area.emit(true)
	
func _on_body_exited(_body: Player) -> void:
	on_interaction_area.emit(false)
