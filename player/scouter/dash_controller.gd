class_name  DashController
extends Node

signal dash_state_changed(bool)
signal dash_attempt_blocked()

@export var dash_speed:float = 1200.0
@export var cooldown:float = 0.6
@export var dash_duration:float = 0.14

var is_dashing: bool = false

var _is_on_dash_cooldown: bool = false
var _cooldown_timer: float = 0.0

@onready var dash_duration_timer: float = dash_duration

func _process(delta: float) -> void:
	if dash_duration_timer > 0:
		dash_duration_timer -= delta	
	if is_dashing && dash_duration_timer <= 0:
		_change_dash_state(false)

	_handle_cooldown_timer(delta)


func dash() -> void:
	if not _is_on_dash_cooldown:
		dash_duration_timer = dash_duration
		_cooldown_timer = cooldown
		_change_dash_state(true)
		_is_on_dash_cooldown = true
	else:
		dash_attempt_blocked.emit()
		print("player can`t dash, because its on cooldown")


func _change_dash_state(is_available: bool):
	is_dashing = is_available
	dash_state_changed.emit(is_available)


func _handle_cooldown_timer(delta: float) -> void:
	if _cooldown_timer > 0:
		_cooldown_timer -= delta
	else:
		_is_on_dash_cooldown = false	


func _on_dash_duration_timer_timeout() -> void:
	_change_dash_state(false)
