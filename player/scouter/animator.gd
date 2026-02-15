extends Node

@export var animation_tree: AnimationTree
@onready var player: Player = get_owner()

@export var is_running = false

const _IDLE_BLEND_POSITION = "parameters/Idle/BlendSpace2D/blend_position"
const _RUNNING_BLEND_POSITION = "parameters/Running/BlendSpace2D/blend_position"
const _IS_RUNNING = "parameters/conditions/isEnabled"
const _IS_IDLE = "parameters/conditions/isIdle"

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var velocity = player.velocity.normalized()

	_set_animation_tree_conditions(velocity)

	if velocity != Vector2.ZERO:
		_animate(velocity)


func _set_animation_tree_conditions(velocity: Vector2) -> void:
	is_running = velocity != Vector2.ZERO
	var is_idle = velocity == Vector2.ZERO

	animation_tree.set(
		_IS_RUNNING, 
		is_running,
	)
	
	animation_tree.set(
		_IS_IDLE,
		is_idle,
	)

func _animate(velocity: Vector2):
	animation_tree.set(
		_RUNNING_BLEND_POSITION,
		velocity,
	)
	animation_tree.set(
		_IDLE_BLEND_POSITION,
		velocity,
	)
