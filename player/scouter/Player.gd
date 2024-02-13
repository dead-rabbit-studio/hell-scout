class_name Player extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }

signal changed_direction(PLAYER_DIRECTION)
signal player_position_update(Vector2)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: Health = $Health 

@export var speed = 400.0
@export var max_health = 110

var _currentDirectionVector: Vector2 = Vector2.ZERO 
var _lastDirection: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT
var melee_attack: Area2D

func _ready() -> void : 
	melee_attack = preload("res://weapons/melee_attack.tscn").instantiate()
	health.max_health = max_health
	health.is_mortal = false
	connect("changed_direction", melee_attack._on_player_changed_direction)
	connect("player_position_update", melee_attack._on_player_position_update)

func _process(delta: float) -> void:
	if health.is_alive:
#		health.damage(10 * delta)
#		print_debug("Player health:" + str(health.current))
		_animate()
		_update_sprite_direction()
		
		if Input.is_action_pressed('attack'):
			if melee_attack.get_parent() == null:
				add_child(melee_attack)
				melee_attack.attack()
		else:
			if melee_attack.get_parent() != null:
				remove_child(melee_attack)

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
		animated_sprite.flip_h = false
	elif _currentDirectionVector.x < 0:
		animated_sprite.flip_h = true

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
			
func _on_health_depleted():
	print_debug("player has died")

func _on_melee_attack_body_entered(body: Node2D) -> void:
	print_debug("player hit someone")
	const damage = 10
	if body.has_node('Health'): 
		body.health.damage(damage)
		print_debug("player dealt: " + str(damage))
		


