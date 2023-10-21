extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }

signal changed_direction(PLAYER_DIRECTION)
signal player_position_update(Vector2)

@export var SPEED = 400.0

var lastDirection: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void : 
	animatedSprite.play("idle")

func _physics_process(_delta: float) -> void:
	var directionVector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var playerDirection = direction_vector_to_player_direction(directionVector)

	if playerDirection != lastDirection:
		lastDirection = playerDirection
		changed_direction.emit(lastDirection)
		
	velocity = directionVector * SPEED

	if velocity.length() > 0:
		animatedSprite.play('running')
	else: 
		animatedSprite.play('idle')
		
	if directionVector.x > 0:
		animatedSprite.scale.x = 1
	elif directionVector.x < 0:
		animatedSprite.scale.x = -1
		
	move_and_slide()
	player_position_update.emit(global_position)

func direction_vector_to_player_direction(directionVector: Vector2) -> PLAYER_DIRECTION: 
	var playerDirection: PLAYER_DIRECTION = lastDirection;
	
	if directionVector == Vector2(-1, 0):
		playerDirection = PLAYER_DIRECTION.LEFT
	if directionVector == Vector2(0, -1):
		playerDirection = PLAYER_DIRECTION.TOP
	if directionVector == Vector2(1, 0):
		playerDirection = PLAYER_DIRECTION.RIGHT
	if directionVector == Vector2(0, 1):
		playerDirection = PLAYER_DIRECTION.BOTTOM
	
	return playerDirection; 
