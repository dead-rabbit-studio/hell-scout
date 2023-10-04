extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }
signal changed_direction(PLAYER_DIRECTION)
const SPEED = 400.0
var lastDirection: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT

func _physics_process(delta: float) -> void:
	var directionVector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var playerDirection = direction_vector_to_player_direction(directionVector)
	print_debug(str(playerDirection) + " " + str(directionVector))	

	if playerDirection != lastDirection:
		print_debug("Player changed direction")
		lastDirection = playerDirection
		changed_direction.emit(lastDirection)
		
	velocity = directionVector * SPEED
	move_and_slide()

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
