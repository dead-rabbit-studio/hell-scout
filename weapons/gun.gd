extends Node
signal gun_was_fired(bullet: RigidBody2D)

@export var speed:int  = 1200
@export var gun_direction: Vector2 = Vector2.RIGHT

const _gun_front_position: int = 25

func _shoot() -> void:
	var bullet: RigidBody2D = preload('res://weapons/bullet.tscn').instantiate()
	var bullet_direction: Vector2 = _get_bullet_direction()
	var gunfireStartPosition: Vector2 = get_parent().position + _gun_position()
	
	bullet.linear_velocity = bullet_direction.normalized() * speed
	bullet.global_position = gunfireStartPosition
	gun_was_fired.emit(bullet)
	
func _get_bullet_direction() -> Vector2:
	return gun_direction

func _gun_position() -> Vector2:
	return gun_direction * _gun_front_position
			
func _on_bullet_spawner_timeout() -> void:
	_shoot()	

func _on_player_changed_direction(direction: Vector2):
	gun_direction = direction;
