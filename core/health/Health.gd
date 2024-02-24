class_name Health extends Node

signal depleted

@export var is_alive = true
@export var is_mortal = true
@export var max_health = 100
@export var current: float = max_health
	
func heal(heal_points: float):
	var health_after_heal = current + heal_points
	if health_after_heal > max_health: 
		current = max_health
	current += heal_points

func damage(damage_points: float):
	if is_alive:
		var health_after_hit = current - damage_points
		if health_after_hit < 0: current = 0
		else: current -= damage_points
		
		if current == 0 and !is_mortal:
			print_debug("player has died")
			is_alive = false
			depleted.emit()
	
func revive(): current = max_health
