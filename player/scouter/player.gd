class_name Player extends CharacterBody2D

signal health_changed(int)
signal changed_direction(direction: Vector2)
signal object_collected()

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var interactor: Interactor = $Interactor

@export var speed:float = 400.0
@export var dash_speed:float  = 1200.0
@export var max_health:int = 110
@export var is_alive: bool = true
@export var is_imortal: bool = true
@export var player_area: CollisionShape2D
@export var health: Health
@export var controller: Controller
@export var dash_controller: DashController

var _current_direction_vector: Vector2 = Vector2.ZERO 
var _last_direction: Vector2 = Vector2.RIGHT

var _melee_attack_scene = preload(R.scenes.melee_attack)
var _current_melee_attack: Area2D = null


func take_damage(damage: float):
	health.damage(damage)
	health_changed.emit(health.current)


func die(): 
	print_debug(R.strings.player_has_died)
	controller.is_enabled = false
	if _current_melee_attack != null:
		_current_melee_attack.queue_free()
		_current_melee_attack = null
	animation_tree.active = false


func _ready() -> void : 
	health.max_health = max_health
	print_debug("current health" + str(health.current))
	health_changed.emit(health.current)
	health.is_mortal = is_imortal


func _process(_delta: float) -> void:
	if !is_alive:
		health.kill()
	

func _move_player(direction: Vector2):
	_current_direction_vector = direction
	
	if _current_direction_vector != _last_direction and _current_direction_vector != Vector2.ZERO:
		_last_direction = _current_direction_vector
		changed_direction.emit(_last_direction)

	
	var current_speed = 0
	if dash_controller.is_dashing:
		current_speed = dash_controller.dash_speed
	else:
		current_speed = speed

	velocity = _current_direction_vector * current_speed
	move_and_slide()


func _on_health_depleted():
	die()


func _on_interactor_interacted() -> void:
	object_collected.emit()


func _on_controller_interact() -> void:
	interactor.interact()


func _on_controller_attacked(_is_attacking:bool) -> void:
	if _is_attacking and is_alive:
		if _current_melee_attack == null:
			_current_melee_attack = _melee_attack_scene.instantiate()
			add_child(_current_melee_attack)
			_current_melee_attack.connect("tree_exiting", func(): _current_melee_attack = null)
			_current_melee_attack._on_player_changed_direction(_last_direction)
		_current_melee_attack.attack(_is_attacking)


func _on_controller_moved(direction:Vector2) -> void:
	_move_player(direction)


func _on_interactable_interaction_state_changed(is_interactable:bool) -> void:
	interactor.is_enabled = is_interactable


func _on_timer_timeout() -> void:
	take_damage(1)


func _on_controller_dash() -> void:
	dash_controller.dash()
