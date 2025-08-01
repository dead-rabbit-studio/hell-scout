class_name LevelController
extends Node2D

signal level_status_change(int)
signal player_health_changed(int)
signal dash_state_changed(bool)
signal dash_attempt_blocked()

@export var player: Player 
@export var mob_spawner: Timer 

var CreeperClass = preload('res://npcs/creeper/creeper.tscn')


func _enter_tree() -> void:
	player.health.depleted.connect(_on_player_health_depleted)
	player.health_changed.connect(_on_player_health_changed)
	player.dash_state_changed.connect(_on_dash_state_changed)
	player.dash_attempt_blocked.connect(_on_dash_attempt_blocked)


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
	

func _spawn_creeper() -> void:
	var creeper: Creeper = CreeperClass.instantiate()
	creeper.position = _get_spawn_position_inside_area(player.global_position, 50) 
	add_child(creeper)
	

func _get_spawn_position_inside_area(player_position:Vector2, radius: float) -> Vector2:
	var random_angle = randf() * PI * 2
	
	var x = player_position.x + radius * cos(random_angle)
	var y = player_position.y + radius * sin(random_angle)
	
	return Vector2(x, y)


func  _on_player_health_changed(current_hp: int) -> void:
	player_health_changed.emit(current_hp)


func _on_interactable_on_interaction_area_entered() -> void:
	pass # Replace with function body.


func _on_dash_state_changed(is_dashing: bool) -> void:
	dash_state_changed.emit(is_dashing)


func _on_dash_attempt_blocked() -> void:
	dash_attempt_blocked.emit()
