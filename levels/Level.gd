extends Node2D

@onready var player: Player = $Player
var CreeperClass = preload('res://npcs/creeper/creeper.tscn')

func _on_gun_gun_was_fired(bullet: RigidBody2D) -> void:
	add_child(bullet) 

func _on_mob_spawner_timeout() -> void:
	print_debug("new enemy added")
#	_spawn_creeper()
	
func _spawn_creeper() -> void:
	var creeper: Creeper = CreeperClass.instantiate()
	creeper.position = _get_spawn_position_inside_area(player.global_position, 50) 
	player.player_position_update.connect(creeper._on_player_player_position_update)
	add_child(creeper)
	
func _get_spawn_position_inside_area(center_of_area:Vector2, radius: float) -> Vector2:
	var player_position = player.global_position
	var center_y = player_position.y    
	
	var random_angle = randf() * PI * 2
	
	var x = player_position.x + radius * cos(random_angle)
	var y = player_position.y + radius * sin(random_angle)
	
	return Vector2(x, y)
