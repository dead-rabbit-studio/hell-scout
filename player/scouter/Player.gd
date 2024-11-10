class_name Player extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }

signal changed_direction(PLAYER_DIRECTION)
signal player_position_update(Vector2)

# @onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var playerArea: CollisionShape2D = $PlayerArea/CollisionShape2D
@onready var health: Health = $Health 

@export var speed = 400.0
@export var max_health = 110
@export var is_alive = true

var _currentDirectionVector: Vector2 = Vector2.ZERO 
var _lastDirection: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT
var melee_attack: Area2D

func take_damage(damage: float):
	health.damage(damage)

func _ready() -> void : 
	melee_attack = preload("res://weapons/melee_attack.tscn").instantiate()
	health.max_health = max_health
	health.is_mortal = true
	connect("changed_direction", melee_attack._on_player_changed_direction)
	connect("player_position_update", melee_attack._on_player_position_update)

func _process(_delta: float) -> void:
	if is_alive:
		_animate()
		_update_sprite_direction()
		
		if Input.is_action_pressed('attack'):
			if melee_attack.get_parent() == null:
				add_child(melee_attack)
				melee_attack.attack()
		else:
			if melee_attack.get_parent() != null:
				remove_child(melee_attack)
	else:
		health.kill()

func _physics_process(_delta: float) -> void:
	if is_alive:
		_move_player()
	
func _move_player():
	_currentDirectionVector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var playerDirection: PLAYER_DIRECTION = get_current_direction()

	if playerDirection != _lastDirection:
		_lastDirection = playerDirection
		changed_direction.emit(_lastDirection)
		
	velocity = _currentDirectionVector * speed
	move_and_slide()
	player_position_update.emit(global_position)
	
func _animate():
	pass
	# if velocity.length() > 0:
	# 	animated_sprite.play('running')
	# else: 
	# 	animated_sprite.play('idle')	

func _update_sprite_direction():
	pass
	# if _currentDirectionVector.x > 0:
	# 	animated_sprite.flip_h = false
	# elif _currentDirectionVector.x < 0:
	# 	animated_sprite.flip_h = true

func get_current_direction() -> PLAYER_DIRECTION: 
	var playerDirection: PLAYER_DIRECTION = _lastDirection;
	
	if _currentDirectionVector == Vector2(-1, 0):
		playerDirection = PLAYER_DIRECTION.LEFT
	if _currentDirectionVector == Vector2(0, -1):
		playerDirection = PLAYER_DIRECTION.TOP
	if _currentDirectionVector == Vector2(1, 0):
		playerDirection = PLAYER_DIRECTION.RIGHT
	if _currentDirectionVector == Vector2(0, 1):
		playerDirection = PLAYER_DIRECTION.BOTTOM
	
	return playerDirection; 
	
func _on_health_depleted():
	print_debug("player has died")
