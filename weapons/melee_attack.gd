class_name MeleeAttack extends Area2D

enum ATTACK_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }
@export var attack_direction: ATTACK_DIRECTION = ATTACK_DIRECTION.RIGHT
@onready var melee_area_shape: RectangleShape2D = $CollisionShape2D.shape as RectangleShape2D
@onready var _attack_vfx = $AttackVfx
var player_position: Vector2 = Vector2.ZERO

func attack() -> void:
	const melee_attack_vertical_size = Vector2(64, 32)
	const melee_attack_horizontal_size = Vector2(32, 64)
	var flip_h = false
	var flip_v = false

	match attack_direction:
		ATTACK_DIRECTION.LEFT:
			_set_attack_position(Vector2(-melee_attack_horizontal_size.x, 0))
			_set_attack_shape(melee_attack_horizontal_size)
			_attack_vfx.rotation = 0
			flip_h = true
			
			
		ATTACK_DIRECTION.TOP:
			_set_attack_position(Vector2(0, -melee_attack_vertical_size.y))
			_set_attack_shape(melee_attack_vertical_size)
			_attack_vfx.rotation = -90
			_attack_vfx.flip_v = false
			flip_v = true
			
			
		ATTACK_DIRECTION.RIGHT:
			_set_attack_position(Vector2(melee_attack_horizontal_size.x, 0))
			_set_attack_shape(melee_attack_horizontal_size)
			_attack_vfx.rotation = 0
			flip_h = false
			
			
		ATTACK_DIRECTION.BOTTOM:
			_set_attack_position(Vector2(0, melee_attack_vertical_size.y))
			_set_attack_shape(melee_attack_vertical_size)
			_attack_vfx.rotation = 90
			flip_v = true
	
	_attack_vfx.flip_h = flip_h
	_attack_vfx.flip_v = flip_v
			
			
			
	_attack_vfx.play("attack")

func _set_attack_position(new_position: Vector2) -> void:
	global_position = player_position + new_position

func _set_attack_shape(size: Vector2) -> void:
	melee_area_shape.size = size

func _on_player_changed_direction(player_direction):
	attack_direction = player_direction;
	
func _on_player_position_update(player_position_update: Vector2):
	player_position = player_position_update 
	
