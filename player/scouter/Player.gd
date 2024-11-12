class_name Player extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }

signal changed_direction(PLAYER_DIRECTION)
signal player_position_update(Vector2)

@onready var player_area: CollisionShape2D = $PlayerArea/CollisionShape2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var health: Health = $Health 

@export var speed = 400.0
@export var max_health = 110
@export var is_alive = true

var _current_direction_vector: Vector2 = Vector2.ZERO 
var _lastDirection: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT
var _MeleeAttack: Area2D = preload(R.scenes.melee_attack).instantiate()

func take_damage(damage: float):
	health.damage(damage)

func _ready() -> void : 
	health.max_health = max_health
	health.is_mortal = true
	connect("changed_direction", _MeleeAttack._on_player_changed_direction)
	connect("player_position_update", _MeleeAttack._on_player_position_update)

func _process(_delta: float) -> void:
	if is_alive:
		if Input.is_action_pressed(R.inputs.attack):
			if _MeleeAttack.get_parent() == null:
				add_child(_MeleeAttack)
				_MeleeAttack.attack()
		else:
			if _MeleeAttack.get_parent() != null:
				remove_child(_MeleeAttack)
	else:
		health.kill()

func _physics_process(_delta: float) -> void:
	if is_alive:
		_move_player()
	
func _move_player():
	_current_direction_vector = Input.get_vector(R.inputs.move_left, R.inputs.move_right, R.inputs.move_up, R.inputs.move_down)
	var player_direction: PLAYER_DIRECTION = get_current_direction()

	if player_direction != _lastDirection:
		_lastDirection = player_direction
		changed_direction.emit(_lastDirection)
		
	velocity = _current_direction_vector * speed
	move_and_slide()
	player_position_update.emit(global_position)
	
func get_current_direction() -> PLAYER_DIRECTION: 
	var playerDirection: PLAYER_DIRECTION = _lastDirection;
	
	if _current_direction_vector == Vector2(-1, 0):
		playerDirection = PLAYER_DIRECTION.LEFT
	if _current_direction_vector == Vector2(0, -1):
		playerDirection = PLAYER_DIRECTION.TOP
	if _current_direction_vector == Vector2(1, 0):
		playerDirection = PLAYER_DIRECTION.RIGHT
	if _current_direction_vector == Vector2(0, 1):
		playerDirection = PLAYER_DIRECTION.BOTTOM
	
	return playerDirection; 
	
func _on_health_depleted():
	print_debug(R.strings.player_has_died)
