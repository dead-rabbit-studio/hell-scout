extends Node

signal gun_was_fired(bullet: RigidBody2D)

var speed = 1200

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func shoot() -> void:
	var gunFrontPosition = 50
	
	var bullet: RigidBody2D = preload('res://bullet.tscn').instantiate()	
	var direction: Vector2 = Vector2(1, 0)
	var gunfirePosition: Vector2 = get_parent().position + Vector2(gunFrontPosition, 0)
	
	bullet.linear_velocity = direction.normalized() * speed
	bullet.global_position = gunfirePosition
	gun_was_fired.emit(bullet)

func _on_bullet_spawner_timeout() -> void:
	shoot()	
