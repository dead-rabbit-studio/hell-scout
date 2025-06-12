class_name Player extends CharacterBody2D
enum PLAYER_DIRECTION { LEFT, TOP, RIGHT, BOTTOM }

signal changed_direction(PLAYER_DIRECTION)
signal player_position_update(Vector2)
signal object_collected()

@onready var player_area: CollisionShape2D = $PlayerArea/CollisionShape2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var health: Health = $Health 
@onready var interactor: Interactor = $Interactor
@onready var controller: Controller = $Controller
@export var speed = 400.0
@export var max_health = 110
@export var is_alive = true
@export var controller2: Controller

var _current_direction_vector: Vector2 = Vector2.ZERO 
var _lastDirection: R.Directions = R.Directions.RIGHT

var _MeleeAttack: Area2D = preload(R.scenes.melee_attack).instantiate()

func take_damage(damage: float):
	health.damage(damage)

func die(): 
	print_debug(R.strings.player_has_died)
	controller.is_enabled = false
	remove_child(_MeleeAttack)
	animation_tree.active = false

func _ready() -> void : 
	health.max_health = max_health
	health.is_mortal = true
	connect("changed_direction", _MeleeAttack._on_player_changed_direction)
	connect("player_position_update", _MeleeAttack._on_player_position_update)

func _process(_delta: float) -> void:
	if is_alive:
		if _MeleeAttack.get_parent() != null && !_MeleeAttack.is_attacking:
			remove_child(_MeleeAttack)

func _physics_process(_delta: float) -> void:
	if !is_alive:
		health.kill()
	
func _move_player(direction: Vector2):
	_current_direction_vector = direction
	var player_direction: R.Directions = get_current_direction()

	if player_direction != _lastDirection:
		_lastDirection = player_direction
		changed_direction.emit(_lastDirection)
		
	velocity = _current_direction_vector * speed
	move_and_slide()
	player_position_update.emit(global_position)
	
func get_current_direction() -> R.Directions: 
	var playerDirection: R.Directions = _lastDirection;
	
	if _current_direction_vector == Vector2(-1, 0):
		playerDirection = R.Directions.LEFT
	if _current_direction_vector == Vector2(0, -1):
		playerDirection = R.Directions.UP
	if _current_direction_vector == Vector2(1, 0):
		playerDirection = R.Directions.RIGHT
	if _current_direction_vector == Vector2(0, 1):
		playerDirection = R.Directions.DOWN
	
	return playerDirection; 
	
func _on_health_depleted():
	die()

func _on_interactor_interacted() -> void:
	object_collected.emit()

func _on_controller_interact() -> void:
	interactor.interact()

func _on_controller_attacked(_is_attacking:bool) -> void:
	print("Player on controller attacked")
	if _is_attacking and is_alive:
		if _MeleeAttack.get_parent() == null:
			add_child(_MeleeAttack)
		print("attacking")
	_MeleeAttack.attack(_is_attacking)

func _on_controller_moved(direction:Vector2) -> void:
	_move_player(direction)


func _on_interactable_interaction_state_changed(is_interactable:bool) -> void:
	interactor.is_enabled = is_interactable
