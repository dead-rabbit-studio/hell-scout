extends CharacterBody2D

@export var speed: float = 1.5
@export var line_of_sight_size: float = 80.0

@onready var line_of_sight_area =  $Area2D/CollisionShape2D.shape as CircleShape2D

var playerPosition: Vector2
var player_los: bool = false

func _process(delta: float) -> void:
	line_of_sight_area.radius = line_of_sight_size

func _physics_process(_delta: float) -> void:
	follow_player()
	
func follow_player() -> void: 
	if player_los:
		var distance_from_player_vector: Vector2 = playerPosition - global_position
		var direction: Vector2 = distance_from_player_vector.normalized()
		var distanceLenght: float = abs(distance_from_player_vector.length())
		
		var movement: Vector2 = direction * speed
		
		if distanceLenght > 30:
			move_and_collide(movement)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_los = true	
		print_debug("player_entered")
		playerPosition = body.global_position

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_los = false

func _on_player_player_position_update(new_player_position: Vector2) -> void:
	playerPosition = new_player_position
