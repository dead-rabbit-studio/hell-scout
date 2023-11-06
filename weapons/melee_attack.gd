class_name MeleeAttack extends Area2D

enum ATTACK_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }
@export var attack_direction: ATTACK_DIRECTION = ATTACK_DIRECTION.RIGHT
@onready var melee_area_shape: RectangleShape2D = $CollisionShape2D.shape as RectangleShape2D

var player_position: Vector2 = Vector2.ZERO

func attack() -> void:
	var attack_distance = (melee_area_shape.extents.x * melee_area_shape.extents.y) / 10
	var melee_attack_vertical_size = Vector2(50, 20)
	var melee_attack_horizontal_size = Vector2(20, 50)
	
	match(attack_direction):
		ATTACK_DIRECTION.LEFT:
			global_position = player_position + Vector2(-attack_distance, 0)
			melee_area_shape.size = melee_attack_horizontal_size
		ATTACK_DIRECTION.TOP:
			global_position = player_position + Vector2(0, -attack_distance)
			melee_area_shape.size = melee_attack_vertical_size
		ATTACK_DIRECTION.RIGHT:
			global_position = player_position + Vector2(attack_distance, 0)
			melee_area_shape.size = melee_attack_horizontal_size
		ATTACK_DIRECTION.BOTTOM:
			global_position = player_position + Vector2(0, attack_distance)	
			melee_area_shape.size = melee_attack_vertical_size

func _on_player_changed_direction(player_direction):
	attack_direction = player_direction;
	
func _on_player_position_update(player_position_update: Vector2):
	player_position = player_position_update 
	
