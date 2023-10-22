extends Node
enum GUN_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }
signal gun_was_fired(bullet: RigidBody2D)

@export var speed:int  = 1200
@export var gunDirection: GUN_DIRECTION = GUN_DIRECTION.RIGHT 

const gunFrontPosition: int = 50

func _shoot() -> void:
	var bullet: RigidBody2D = preload('res://weapons/bullet.tscn').instantiate()
	var bullet_direction: Vector2 = _get_bullet_direction()
	var gunfireStartPosition: Vector2 = get_parent().position + _gun_position()
	
	bullet.linear_velocity = bullet_direction.normalized() * speed
	bullet.global_position = gunfireStartPosition
	gun_was_fired.emit(bullet)
	
func _get_bullet_direction() -> Vector2:
	return _gun_front_direction_to_vector2(1, gunDirection)

func _gun_position() -> Vector2:
	return _gun_front_direction_to_vector2(gunFrontPosition, gunDirection)
	
func _gun_front_direction_to_vector2(force: int, gunFrontDirection: GUN_DIRECTION) -> Vector2:
	var resultVector: Vector2;
	match(gunFrontDirection):
		GUN_DIRECTION.LEFT: 
			resultVector = Vector2(-force, 0);
		GUN_DIRECTION.TOP:
			resultVector = Vector2(0, -force);
		GUN_DIRECTION.RIGHT:
			resultVector = Vector2(force, 0);
		GUN_DIRECTION.BOTTOM:
			resultVector = Vector2(0, force)
	return resultVector;
			
func _on_bullet_spawner_timeout() -> void:
	_shoot()	

func _on_player_changed_direction(PLAYER_DIRECTION):
	gunDirection = PLAYER_DIRECTION;
