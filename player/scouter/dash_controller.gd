class_name  DashController
extends Node

@export var dash_speed:float = 1200.0
@export var cooldown:float = 0.6
@export var dash_duration:float = 0.14

@onready var dash_duration_timer: Timer = $DashDurationTimer

var is_dashing: bool = false
var _is_on_dash_cooldown: bool = false
var _cooldown_timer: float = 0.0

func _process(delta: float) -> void:
	_handle_cooldown_timer(delta)


func dash() -> void:
	if not _is_on_dash_cooldown:
		dash_duration_timer.start(dash_duration)
		_cooldown_timer = cooldown
		is_dashing = true
		_is_on_dash_cooldown = true
		print("player is dashing")
	else:
		print("player can´t dash, because its on cooldown")


func _handle_cooldown_timer(delta: float) -> void:
	if _cooldown_timer > 0:
		_cooldown_timer -= delta
	else:
		_is_on_dash_cooldown = false	


func _on_dash_duration_timer_timeout() -> void:
	is_dashing = false
