extends Node2D

signal level_status_change(int)

@onready var player: Player = $Player
@onready var mob_spawner: Timer = $MobSpawner

var CreeperClass = preload('res://npcs/creeper/creeper.tscn')

func _ready() -> void:
	player.health.depleted.connect(_on_player_health_depleted)

func _on_gun_gun_was_fired(bullet: RigidBody2D) -> void:
	add_child(bullet) 

func _on_mob_spawner_timeout() -> void:
	print_debug("new enemy added")
	_spawn_creeper()
	
func _on_player_health_depleted() -> void: 
	_game_over()
			
func _kill_all_mobs(): 
	for child in self.get_children():
		if child.has_method("die"):
			child.die()	
	
func _game_over() -> void:
	print_debug("level finished")
	level_status_change.emit(LevelStatus.LOST)
	mob_spawner.stop()
	#_kill_all_mobs()
	
func _spawn_creeper() -> void:
	var creeper: Creeper = CreeperClass.instantiate()
	creeper.position = _get_spawn_position_inside_area(player.global_position, 50) 
	player.player_position_update.connect(creeper._on_player_player_position_update)
	add_child(creeper)
	
func _get_spawn_position_inside_area(player_position:Vector2, radius: float) -> Vector2:
	var random_angle = randf() * PI * 2
	
	var x = player_position.x + radius * cos(random_angle)
	var y = player_position.y + radius * sin(random_angle)
	
	return Vector2(x, y)
