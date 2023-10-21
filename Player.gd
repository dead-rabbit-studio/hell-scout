extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }

signal changed_direction(PLAYER_DIRECTION)
signal player_position_update(Vector2)

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED = 400.0

var _currentDirectionVector: Vector2 = Vector2.ZERO 
var _lastDirection: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT

func _ready() -> void : 
	animatedSprite.play("idle")

func _process(delta: float) -> void:
	animate()
	update_sprite_direction()

func _physics_process(_delta: float) -> void:
	_currentDirectionVector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var playerDirection = map_direction_vector_to_player_direction(_currentDirectionVector)

	if playerDirection != _lastDirection:
		_lastDirection = playerDirection
		changed_direction.emit(_lastDirection)
		
	velocity = _currentDirectionVector * SPEED
		
	move_and_slide()
	player_position_update.emit(global_position)
	
func animate():
	if velocity.length() > 0:
		animatedSprite.play('running')
	else: 
		animatedSprite.play('idle')	
		
func update_sprite_direction():
	if _currentDirectionVector.x > 0:
		animatedSprite.scale.x = 1
	elif _currentDirectionVector.x < 0:
		animatedSprite.scale.x = -1

func map_direction_vector_to_player_direction(directionVector: Vector2) -> PLAYER_DIRECTION: 
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
