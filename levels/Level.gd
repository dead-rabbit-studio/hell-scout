extends Node2D

@onready var player: Player = $Player
var CreeperClass = preload('res://npcs/creeper/creeper.tscn')

func _on_gun_gun_was_fired(bullet: RigidBody2D) -> void:
	add_child(bullet) 

func _on_mob_spawner_timeout() -> void:
	print_debug("new enemy added")
	spawn_creeper()
	
func spawn_creeper() -> void:
	var creeper: Creeper = CreeperClass.instantiate()
	creeper.position = player.global_position
	player.player_position_update.connect(creeper._on_player_player_position_update)
	add_child(creeper)
