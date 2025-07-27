class_name  DashController
extends Node

signal dash_state_changed(bool)
signal dash_attempt_blocked()

@export var dash_speed:float = 1200.0
@export var cooldown:float = 0.6
@export var dash_duration:float = 0.14
@export var dash_duration_timer: Timer
@export var dash_cooldown_timer: Timer

var is_dashing: bool = false

var _is_on_dash_cooldown: bool = false
var _cooldown_timer: float = 0.0


func _enter_tree() -> void:
	dash_duration_timer.timeout.connect(_on_dash_duration_timer_timeout)
	dash_cooldown_timer.timeout.connect(_on_dash_cooldowntimer_timeout)


func dash() -> void:
	if not _is_on_dash_cooldown:
		dash_duration_timer.start(dash_duration)
		_cooldown_timer = cooldown
		_change_dash_state(true)
		_start_cooldown()
	else:
		dash_attempt_blocked.emit()
		print("player can`t dash, because its on cooldown")


func _change_dash_state(is_available: bool):
	is_dashing = is_available
	dash_state_changed.emit(is_available)


func _start_cooldown() -> void:
	dash_cooldown_timer.start(cooldown)
	_is_on_dash_cooldown = true


func _on_dash_duration_timer_timeout() -> void:
	_change_dash_state(false)


func _on_dash_cooldowntimer_timeout() -> void:
	_is_on_dash_cooldown = false	
