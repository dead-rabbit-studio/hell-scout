class_name Creeper extends CharacterBody2D

const NODE_NAME = "Creeper"

@export var speed: float = 80
@export var line_of_sight_size: float = 150.0
@export var max_health: float = 3.0
@export var damage: float = 3.0

@onready var line_of_sight_area: CircleShape2D =  $EngageArea/CollisionShape2D.shape as CircleShape2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var detect_raycast: RayCast2D = $RayCast2D
@onready var health: Health = $Health

var _player_position: Vector2
var _player_in_sight: Node2D = null
var _player_los: bool = false


func take_damage(damage_taken: float):
	health.damage(damage_taken)


func die() -> void:
	queue_free()
	print_debug("a creeper has died")


func _ready() -> void:
	set_collision_layer_value(2, false)
	set_collision_mask_value(1, true)
	health.current = max_health
	detect_raycast.add_exception(self)
	print_debug("new creeper health:" + str(health.current))
	if health.is_alive:
		line_of_sight_area.radius = line_of_sight_size


func _process(delta: float) -> void:
	if health.is_alive:
		_follow_player(delta)


func _physics_process(delta: float) -> void:
	_detect_player(delta)


func _follow_player(delta: float) -> void: 
	const personal_space_area = 30
	if _player_los:
		var distance_from_player_vector: Vector2 = _player_in_sight.global_position - global_position
		var direction: Vector2 = distance_from_player_vector.normalized()
		var distance_lenght: float = distance_from_player_vector.length()
		
		var movement: Vector2 = direction * (speed * delta)
		
		print_debug("Creeper: Player in line of sight" + str(_player_position) + " distance: " + str(distance_lenght))
		if distance_lenght > personal_space_area:
			move_and_collide(movement)		


func _detect_player(_delta: float):
	if _player_in_sight:
		var direction = (_player_in_sight.global_position - global_position).normalized()	
		detect_raycast.global_position = global_position
		detect_raycast.target_position = direction * line_of_sight_size
		detect_raycast.force_raycast_update()

		if detect_raycast.is_colliding():
			var collider = detect_raycast.get_collider()
			print_debug("Raycast hit:", collider.name if collider else "none")
			if collider and collider.is_in_group("Player"):
				print_debug("player is on sight")
				_player_los = true
			else:
				_player_los = false
	else:
		_player_los = false


func _on_health_depleted() -> void:
	die()


func _on_engage_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		_player_in_sight = body
		_player_position = body.global_position
		#_player_los = true


func _on_engage_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		_player_in_sight = null
		_player_los = false
