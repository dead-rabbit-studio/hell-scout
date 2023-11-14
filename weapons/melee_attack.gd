class_name MeleeAttack extends Area2D

enum ATTACK_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }
@export var attack_direction: ATTACK_DIRECTION = ATTACK_DIRECTION.RIGHT
@onready var melee_area_shape: RectangleShape2D = $CollisionShape2D.shape as RectangleShape2D
var player_position: Vector2 = Vector2.ZERO

func attack() -> void:
	const melee_attack_vertical_size = Vector2(64, 32)
	const melee_attack_horizontal_size = Vector2(32, 64)

	match attack_direction:
		ATTACK_DIRECTION.LEFT:
			_set_attack_position(Vector2(-melee_attack_horizontal_size.x + 10, 0))
			_set_attack_shape(melee_attack_horizontal_size)
		ATTACK_DIRECTION.TOP:
			_set_attack_position(Vector2(0, -melee_attack_vertical_size.y / 2))
			_set_attack_shape(melee_attack_vertical_size)
		ATTACK_DIRECTION.RIGHT:
			_set_attack_position(Vector2(melee_attack_horizontal_size.x - 10 , 0))
			_set_attack_shape(melee_attack_horizontal_size)
		ATTACK_DIRECTION.BOTTOM:
			_set_attack_position(Vector2(0, 24))
			_set_attack_shape(melee_attack_vertical_size)

func _set_attack_position(new_position: Vector2) -> void:
	global_position = player_position + new_position

func _set_attack_shape(size: Vector2) -> void:
	melee_area_shape.size = size * 0.5

func _on_player_changed_direction(player_direction):
	attack_direction = player_direction;
	
func _on_player_position_update(player_position_update: Vector2):
	player_position = player_position_update 
	
