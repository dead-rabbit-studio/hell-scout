extends Node

@export var animation_tree: AnimationTree
@onready var player: Player = get_owner()

@export var is_running = false

var _animation_tree_parameter_idle_blend_position = "parameters/Idle/BlendSpace2D/blend_position"
var _animation_tree_parameter_running_blend_position = "parameters/Running/BlendSpace2D/blend_position"
var _animation_tree_parameter_playback = "parameters/playback"
var _animation_tree_parameter_is_running = "parameters/conditions/isRunning"
var _animation_tree_parameter_is_idle = "parameters/conditions/isIdle"

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var velocity = player.velocity.normalized()

	_set_animation_tree_conditions(velocity)

	if velocity == Vector2.ZERO:
		animation_tree.get(_animation_tree_parameter_playback).travel("Idle")
		pass
	else:
		animation_tree.get(_animation_tree_parameter_playback).travel("Running")
		_animate(velocity)


func _set_animation_tree_conditions(velocity: Vector2) -> void:
	is_running = velocity != Vector2.ZERO
	var is_idle = velocity == Vector2.ZERO

	animation_tree.set(
		_animation_tree_parameter_is_running, 
		is_running,
	)
	
	animation_tree.set(
	_animation_tree_parameter_is_idle, 
	is_idle,
	)

func _animate(velocity: Vector2):
		animation_tree.set(
			_animation_tree_parameter_running_blend_position, 
			velocity,
		)
		animation_tree.set(
			_animation_tree_parameter_idle_blend_position, 
			velocity,
		)
