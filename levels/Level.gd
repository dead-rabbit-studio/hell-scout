extends Node2D

@onready var player: Player = $Player
var CreeperClass = preload('res://npcs/creeper/creeper.tscn')

func _ready() -> void:
	player.health.depleted.connect(_on_player_health_depleted)
		
func _on_creeper_player_was_hit(damage: float) -> void:
	print_debug("player took a hit: "  + str(damage))
	player.health.damage(damage)

func _on_gun_gun_was_fired(bullet: RigidBody2D) -> void:
	add_child(bullet) 

func _on_mob_spawner_timeout() -> void:
	print_debug("new enemy added")
	_spawn_creeper()
	
func _on_player_health_depleted() -> void: 
	print_debug("game over")
	
func _spawn_creeper() -> void:
	var creeper: Creeper = CreeperClass.instantiate()
	creeper.position = _get_spawn_position_inside_area(player.global_position, 50) 
	player.player_position_update.connect(creeper._on_player_player_position_update)
	creeper.player_was_hit.connect(_on_creeper_player_was_hit)
	add_child(creeper)
	
func _get_spawn_position_inside_area(center_of_area:Vector2, radius: float) -> Vector2:
	var player_position = player.global_position
	var center_y = player_position.y    
	
	var random_angle = randf() * PI * 2
	
	var x = player_position.x + radius * cos(random_angle)
	var y = player_position.y + radius * sin(random_angle)
	
	return Vector2(x, y)
