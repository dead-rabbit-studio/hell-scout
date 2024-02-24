class_name Creeper extends CharacterBody2D

const NODE_NAME = "Creeper"

@export var speed: float = 80
@export var line_of_sight_size: float = 150.0
@export var max_health: float = 80.0
@export var damage: float = 30.0

@onready var line_of_sight_area: CircleShape2D =  $EngageArea/CollisionShape2D.shape as CircleShape2D
@onready var collisionShape: CollisionShape2D = $CollisionShape2D
@onready var health: Health = $Health

signal player_was_hit(float)

var playerPosition: Vector2
var player_los: bool = false

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, true)
	
func _process(delta: float) -> void:
	if health.is_alive:
		line_of_sight_area.radius = line_of_sight_size

func _physics_process(delta: float) -> void:
	follow_player(delta)
	
func follow_player(delta: float) -> void: 
	const personal_space_area = 30
	if player_los:
		var distance_from_player_vector: Vector2 = playerPosition - global_position
		var direction: Vector2 = distance_from_player_vector.normalized()
		var distanceLenght: float = abs(distance_from_player_vector.length())
		
		var movement: Vector2 = direction * (speed * delta)
		
		if distanceLenght > personal_space_area:
			move_and_collide(movement)
			
func take_damage() -> void: 
	health.damage(100)
	print_debug("enemy health" + str(health.current))

func _on_player_player_position_update(new_player_position: Vector2) -> void:
	playerPosition = new_player_position

func _on_health_depleted() -> void:
	queue_free()
	print_debug("enemy_died")

func _on_engage_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_los = true	
		playerPosition = body.global_position

func _on_engage_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_los = false

func _on_collision_shape_2d_child_entered_tree(node):
	print_debug('Enemy Hit' + str(node))
 
func _on_hitbox_area_entered(area):
	print_debug("Creeper hit the player: " + str(damage))
	player_was_hit.emit(damage)
