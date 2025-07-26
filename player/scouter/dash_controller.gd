class_name  DashController
extends Node

@export var dash_speed:float = 1200.0
@export var cooldown:float = 0.6
@export var dash_duration:float = 0.14

@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer

var is_dashing: bool = false
var _is_on_dash_cooldown: bool = false


func dash():
	if not _is_on_dash_cooldown:
		dash_duration_timer.start(dash_duration)
		is_dashing = true
		_is_on_dash_cooldown = true
		dash_cooldown_timer.start(cooldown)
		print("player is dashing")
	else:
		print("player can´t dash, because its on cooldown")


func _on_dash_duration_timer_timeout() -> void:
	is_dashing = false


func _on_dash_cool_down_timeout() -> void:
	_is_on_dash_cooldown = false
