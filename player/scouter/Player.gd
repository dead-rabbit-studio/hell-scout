class_name Player extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }

signal changed_direction(PLAYER_DIRECTION)
signal player_position_update(Vector2)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: Health = $Health 
@onready var attack_area = $AttackArea
@onready var attack_area_shape: RectangleShape2D = $AttackArea/CollisionShape2D.shape as RectangleShape2D

@export var speed = 400.0
@export var max_health = 110

var _currentDirectionVector: Vector2 = Vector2.ZERO 
var _lastDirection: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT

func _ready() -> void : 
	health.max_health = max_health
	health.is_mortal = false
	remove_child(attack_area)

func _process(delta: float) -> void:
	if health.is_alive:
		health.damage(10 * delta)
		print_debug(health.current)
		_animate()
		_update_sprite_direction()
		
		if Input.is_action_pressed('attack'):
			_calculate_attack_direction(_lastDirection)
			add_child(attack_area)
		else:
			remove_child(attack_area)

func _physics_process(_delta: float) -> void:
	if health.is_alive:
		_move_player()
	
func _move_player():
	_currentDirectionVector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var playerDirection: PLAYER_DIRECTION = _map_direction_vector_to_player_direction(_currentDirectionVector)

	if playerDirection != _lastDirection:
		_lastDirection = playerDirection
		changed_direction.emit(_lastDirection)
		
	velocity = _currentDirectionVector * speed
	move_and_slide()
	player_position_update.emit(global_position)
	
func _animate():
	if  health.is_alive:
		if velocity.length() > 0:
			animated_sprite.play('running')
		else: 
			animated_sprite.play('idle')	
	else:
		animated_sprite.pause()
		
func _update_sprite_direction():
	if _currentDirectionVector.x > 0:
		animated_sprite.scale.x = 1
	elif _currentDirectionVector.x < 0:
		animated_sprite.scale.x = -1

func _map_direction_vector_to_player_direction(directionVector: Vector2) -> PLAYER_DIRECTION: 
	var playerDirection: PLAYER_DIRECTION = _lastDirection;
	
	if directionVector == Vector2(-1, 0):
		playerDirection = PLAYER_DIRECTION.LEFT
	if directionVector == Vector2(0, -1):
		playerDirection = PLAYER_DIRECTION.TOP
	if directionVector == Vector2(1, 0):
		playerDirection = PLAYER_DIRECTION.RIGHT
	if directionVector == Vector2(0, 1):
		playerDirection = PLAYER_DIRECTION.BOTTOM
	
	return playerDirection; 

func _calculate_attack_direction(player_direction: PLAYER_DIRECTION) -> void:
	var attack_distance =  (attack_area_shape.extents.x * attack_area_shape.extents.y) / 10
	
	match(player_direction):
		PLAYER_DIRECTION.LEFT:
			attack_area.global_position = global_position + Vector2(-attack_distance, 0)
		PLAYER_DIRECTION.TOP:
			attack_area.global_position = global_position + Vector2(0, -attack_distance)
		PLAYER_DIRECTION.RIGHT:
			attack_area.global_position = global_position + Vector2(attack_distance, 0)
		PLAYER_DIRECTION.BOTTOM:
			attack_area.global_position = global_position + Vector2(0, attack_distance)	
			
func _on_health_depleted():
	print_debug("player has died")

func _on_attack_area_body_entered(body: Node2D) -> void:
	const damage = 10
	if body.has_node('Health'): 
		body.health.damage(damage)
		print_debug("player dealt: " + str(damage))
