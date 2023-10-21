class_name Health extends Node

signal depleted

@export var is_alive = true
@export var max = 100
@export var current: float = max
	
func heal(heal_points: float):
	var health_after_heal = current + heal_points
	if health_after_heal > max: current = max
	current += heal_points

func damage(damage: float):
	if is_alive:
		var health_after_hit = current - damage
		if health_after_hit < 0: current = 0
		else: current -= damage
		
		if current == 0:
			is_alive = false
			depleted.emit()
	
func revive(): current = max
